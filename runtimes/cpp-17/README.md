
# C++ Runtime 17

This is the Open Runtime that builds and runs C++ code based on a `alpine:3.16` base image. 

The runtime itself uses [Drogon](https://github.com/drogonframework/drogon) as the Web Server to process the execution requests.

To learn more about runtimes, visit [Structure](https://github.com/open-runtimes/open-runtimes#structure) section of the main README.md.

## Usage

1. Create a folder and enter it. Add code into `index.cc` file:


```bash
mkdir cpp-function && cd cpp-function
tee -a index.cc << END
#include "RuntimeResponse.h"
#include "RuntimeRequest.h"
#include "RuntimeOutput.h"
#include "RuntimeContext.h"

namespace runtime {
    class Handler {
    public:
        static RuntimeOutput main(RuntimeContext &context)
        {
            Json::Value result;
            result["n"] = rand() / (RAND_MAX + 1.);
            
            return context.res.json(result);
        }
    };
}

END

```

2. Build the code:

```bash
docker run -e OPEN_RUNTIMES_ENTRYPOINT=index.cc --rm --interactive --tty --volume $PWD:/mnt/code openruntimes/cpp:v3-17 sh helpers/build.sh
```

3. Spin-up open-runtime:

```bash
docker run -p 3000:3000 -e OPEN_RUNTIMES_SECRET=secret-key --rm --interactive --tty --volume $PWD/code.tar.gz:/mnt/code/code.tar.gz:ro openruntimes/cpp:v3-17 sh helpers/start.sh "/usr/local/server/src/function/cpp_runtime"
```

4. In new terminal window, execute function:

```bash
curl -H "x-open-runtimes-secret: secret-key" -X GET http://localhost:3000/
```

Output `{"n":0.7232589496628183}` with random float will be displayed after the execution.

## Local development

1. Clone the [open-runtimes](https://github.com/open-runtimes/open-runtimes) repository:

```bash
git clone https://github.com/open-runtimes/open-runtimes.git
```

2. Enter the C++ runtime folder:

```bash
cd open-runtimes/runtimes/cpp-17
```

3. Run the included example cloud function:

```bash
docker compose up -d
```

4. Execute the function:

```bash
curl -H "x-open-runtimes-secret: secret-key" -H "Content-Type: application/json" -X POST http://localhost:3000/ -d '{"id": "4"}'
```

You can now send `POST` request to `http://localhost:3000`. Make sure you have header `x-open-runtimes-secret: secret-key`.

You can also make changes to the example code and apply the changes with the `docker compose restart` command.

## Notes

- When writing function for this runtime, ensure function named `main` exists in `Handler` class under `runtime` namespace. An example of this is:

```cpp
#include "RuntimeOutput.h"
#include "RuntimeContext.h"

namespace runtime {
    class Handler {
    public:
        static RuntimeOutput main(RuntimeContext &context)
        {
            auto res = context.res;
            return res.send("Hello Open Runtimes 👋");
        }
    };
}
```

- To handle dependencies, you need to include a `CMakeLists.txt` file. Dependencies will be automatically installed.

- The default entrypoint is `index.cc`. If your entrypoint differs, make sure to configure it using `OPEN_RUNTIMES_ENTRYPOINT` environment variable during build, for instance, `OPEN_RUNTIMES_ENTRYPOINT=src/app.cc`.

## Contributing

For security issues, please email security@appwrite.io instead of posting a public issue in GitHub.

You can refer to the [Contributing Guide](https://github.com/open-runtimes/open-runtimes/blob/main/CONTRIBUTING.md) for more info.
