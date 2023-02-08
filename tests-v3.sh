#!/bin/sh
set -e
cd runtimes/${RUNTIME}
docker build -t open-runtimes/test-runtime .
cd ../../
cd tests/resources/functions/${RUNTIME}
echo "Building..."
touch code.tar.gz
tar --exclude code.tar.gz -czf code.tar.gz .
docker run --rm --name open-runtimes-test-build -v "$(pwd)"/code.tar.gz:/usr/code/code.tar.gz:rw -e OPEN_RUNTIMES_ENTRYPOINT=${ENTRYPOINT} -e OPEN_RUNTIMES_SECRET=test-secret-key open-runtimes/test-runtime sh -c "tar -xzf /usr/code/code.tar.gz -C /usr/code && sh /usr/local/src/build.sh"
docker run --rm -d --name open-runtimes-test-serve -v "$(pwd)":/usr/code:rw -e OPEN_RUNTIMES_ENTRYPOINT=${ENTRYPOINT} -e OPEN_RUNTIMES_SECRET=test-secret-key -e CUSTOM_ENV_VAR=customValue -p 3000:3000 open-runtimes/test-runtime sh -c "cp /usr/code/code.tar.gz /tmp/code.tar.gz && sh /usr/local/src/start.sh"
docker run --rm -d --name open-runtimes-test-serve2 -v $(pwd):/usr/code:rw -e OPEN_RUNTIMES_ENTRYPOINT=${ENTRYPOINT} -e OPEN_RUNTIMES_SECRET="" -p 3001:3000 open-runtimes/test-runtime sh -c "cp /usr/code/code.tar.gz /tmp/code.tar.gz && sh /usr/local/src/start.sh"
echo "Waiting for server..."
sleep 10
cd ../../../../
echo "Running tests..."
OPEN_RUNTIMES_SECRET=test-secret-key OPEN_RUNTIMES_ENTRYPOINT=${ENTRYPOINT} vendor/bin/phpunit --configuration phpunit.xml tests/${PHP_CLASS}.php
