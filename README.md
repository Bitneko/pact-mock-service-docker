# Pact Mock Service Docker

Docker image running the pact mock service.
You can pull the latest image from Dockerhub [nczita/pact-mock-service](https://hub.docker.com/r/nczita/pact-mock-service).

## Usage

```sh
# Get the latest version
$ docker pull nczita/pact-mock-service

# Start mock service
$ docker run -d --name pact_mock -P nczita/pact-mock-service

# Get the port of mock service
$ MOCK_PORT=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "8077/tcp") 0).HostPort}}' pact_mock)

# Check if it working
$ curl -H "X-Pact-Mock-Service: true" http://localhost:${MOCK_PORT}
> Mock service running

# Get pact contents
$ curl -X POST \
    -H "X-Pact-Mock-Service: true" \
    -H "Content-Type: application/json" -d '{"consumer" : {"name": "Foo"}, "provider": {"name": "Bar"}}' \
    http://localhost:${MOCK_PORT}/pact

# Stop and remove mock service
$ docker stop pact_mock
$ docker rm pact_mock
```

For examples of the other commands, see this [script](https://github.com/pact-foundation/pact-mock_service/blob/master/script/example.sh)

Dockerhub: [nczita/pact-mock-service](https://hub.docker.com/r/nczita/pact-mock-service).
