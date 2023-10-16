# Codec2 Integration Tests

This is a Docker container setup for testing pycodec2 with different versions
of codec2.

Right now there's only one codec2 version pycodec2 supports, 1.2.0, so the test
is straightforward.

## Build & Run

To build and run this container, execute the following steps.

1. Build the Docker image.

    ```shell
    docker build -t codec2-integration-tests -f - .. < Dockerfile
    ```

1. Run the test:

    ```shell
    docker run codec2-integration-tests:latest bash ./pycodec2/codec2-integration-tests/test.sh
    ```
