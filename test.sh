#!/bin/bash

echo "Image: $IMAGE"
echo "Build: docker run --rm --name open-runtimes-test-build -v $(pwd):/mnt/code:rw -e $ENTRYPOINT open-runtimes/test-runtime sh -c \"sh helpers/build.sh '$OPEN_RUNTIMES_BUILD_COMMAND'\""
echo "Run: docker run -d --rm --name open-runtimes-test-serve -v $(pwd)/code.tar.gz:/mnt/code/code.tar.gz:rw -e $ENTRYPOINT -e OPEN_RUNTIMES_SECRET=test-secret-key -e CUSTOM_ENV_VAR=customValue -p 3000:3000 open-runtimes/test-runtime sh -c \"sh helpers/start.sh '$OPEN_RUNTIMES_START_COMMAND'\""
echo "Run Test: $ENTRYPOINT vendor/bin/phpunit --configuration phpunit.xml tests/$TEST_CLASS.php"
