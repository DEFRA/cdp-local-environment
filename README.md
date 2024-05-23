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
    networks:
      - cdpnet
    extra_hosts:
      - "host.docker.internal:host-gateway"
      - "cdp.127.0.0.1.sslip.io:host-gateway"
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

## Mixing with local running services

I.e mixing with non docker compose services, e.g. from your IDE.

* Stop the compose service

  `docker compose stop cdp-portal-backend`

  This will free up the port

* Launch the local service from terminal or IDE

And everything __should__ work (if envvars are correct)

## Custom URL

By default you can access the portal through the frontend on

   http://cdp.127.0.0.1.sslip.io:3333

This uses __sslip.io__ to resolve to the local IP on your machine.

You can however go direct to services, e.g. `cdp-portal-frontend` at http://localhost:3000

Note you may need to update some envars to keep OICD login happy etc.

### Changing custom URL

E.g. if you want to use port 80:

* Change `/config/cdp-portal-frontend.env`

   ```
   APP_BASE_URL=http://cdp.127.0.0.1.sslip.io
   ```

* Open your browser with [http://cdp.127.0.0.1.sslip.io](http://cdp.127.0.0.1.sslip.io)

Or if you want to use use IPv6 (and port 80):

* Change `/config/cdp-portal-frontend.env`

   ```
   APP_BASE_URL=http://cdp.--1.sslip.io
   ```

* Change `/config/local_defaults.env`

   ```
   OIDC_WELL_KNOWN_CONFIGURATION_URL=http://cdp.--1.sslip.io:3939/......

   AzureAd__Instance=http://cdp.--1.sslip.io:3939/
   ```

   Note to keep the __3939__ port in the URL as it will tunnel through to the stubs.

* Change `/compose.yml`

    Add a new `extra__hosts` to the services that already have that:

    ```
    extra_hosts:
      - "host.docker.internal:host-gateway"
      - "cdp.127.0.0.1.sslip.io:host-gateway"
      - "cdp.--1.sslip.io:host-gateway"
    ```

    Note we already added two __cdp....` hosts but you can add more.



* Open your browser with [http://cdp.--1.sslip.io](http://cdp.--1.sslip.io)

## Squid proxy

To use a local squid proxy for outgoing http traffic:

* Start the proxy

  ```
  docker compose up -d squid
  ```

* To test, configure a browser to use the proxy, e.g. with `curl`

  ```
  curl -x http://localhost:3128 httpstat.us/200
  ```

* To use in local CDP services in this setup,
  uncomment this line in `config/local-defaults.conf`

  ```
  CDP_HTTP_PROXY=http://squid:3128
  ```

* To use in other CDP services, e.g. from your shell or IDE
  set the this env-var:

  ```
  export CDP_HTTP_PROXY=http://localhost:3128
  ```
