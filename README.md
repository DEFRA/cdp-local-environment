# Docker Compose for local development

## Requirements

 - docker (recent version will include compose as part of the install)
 - login for the ECR registry (this will be replaced by artifact in the future)


## Starting up just Infrastructure
Starting just the supporting infrastructure services can be done by starting docker compose without a `--profile`.

```sh
$ docker compose up
```

This will start:
 - MongoDB
 - Redis
 - LocalStack

The mongodb instance is persistend to a volume called `cdp-infra-mongodb`. Redis and localstack are not persistened between restarts.

## Starting a profile

```sh
$ docker compose --profile portal up
```

### Running a different version
By default the profile will run the latest version of the image.
You can override this by setting the SERVICE_NAME variable to be the version you need.
This can either be done as an export or as part of the command, for example:
```
$ CDP_PORTAL_FRONTEND=0.66.0 CDP_SELF_SERVICE_OPS=0.10.0 docker compose --profile portal up
```

or as env vars
```sh
$ export CDP_PORTAL_FRONTEND=0.66.0
$ export CDP_SELF_SERVICE_OPS=0.10.0
docker compose --profile portal up
```


## Adding services and Creating a profile

First, add the service definition to the compose.yml:

```yaml
  service-name:
    image: 163841473800.dkr.ecr.eu-west-2.amazonaws.com/image-name:${SERVICE_NAME:-latest}
    container_name: service-name
    network_mode: "host"
    env_file:
      - ./config/local-defaults.env
      - ./config/service-name.env
    environment:
      - PORT=1234                      # NodeJS only
      - ASPNETCORE_URLS=http://+:1234  # C Sharp only
    profiles:
      - profile-name
```

You'll need to replace:

|                 |                                                                                 |
|---------------------------------------------------------------------------------------------------|
| service-name    | actual service name (multiple places: section header, container_name, env_file) |
| image-name      | name of docker image, generally same as service-name                            |
| PORT            | a unique port number, not used by other services in the profile (nodejs only)   |
| ASPNETCORE_URLS | a unique port number, not used by other services in the profile (c# only)       |
| profile-name    | the same of the profile its part of                                             |


Next you'll need to create a new .env file for your service in `./config`. The file name should match the name defined in the `env_file` section of the service definition.
You can place any config settings that are required to run that service locally in that file.
These files should be a set of environment variable key/values pairs, e.g.

```
FOO=bar
MY_FLAG=false
```

## Adding a setup task to a profile

First, add a new service to the docker compose:

```yaml
  setup-{SERVICE_NAME}:
    image: cdp-local-setup:latest
    network_mode: "host"
    env_file:
      - ./config/local-defaults.env
    depends_on:
      - localstack
      - mongodb
      - redis
    volumes:
      - ./scripts/{SERVICE_NAME}:/scripts:ro
    restart: "no"
    profiles:
      - {PROFILE}
```

The image `cdp-local-setup` contains a mongo, redis and localstack/aws client. On startup it runs all the scripts found in `/scripts/*.sh`.

Next create a new folder in `./scripts/{SERVICE_NAME}` and place the init scripts into it. Everything in this folder will be mounted into the cdp-service-init container at runtime.

For some examples, see `./scripts/portal`.


