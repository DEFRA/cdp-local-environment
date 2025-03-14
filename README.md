# Docker Compose for local development

* [Requirements](#requirements)
* [Starting up just Infrastructure](#starting-up-just-infrastructure)
* [Starting a profile](#starting-a-profile)
* [Using with Portal tests](#using-with-portal-tests)
* [Diagnosing issues](#diagnosing-issues)
  * [Docker container logs](#docker-container-logs)
  * [Docker container information](#docker-container-information)
  * [Connect to Redis container](#connect-to-redis-container)
  * [Connect to Mongo Docker](#connect-to-mongo-docker)
* [Mongo failing to connect issues](#mongo-failing-to-connect-issues)
  * [Running a different version](#running-a-different-version)
* [Adding services and Creating a profile](#adding-services-and-creating-a-profile)
* [Adding a setup task to a profile](#adding-a-setup-task-to-a-profile)
* [Mixing with local running services](#mixing-with-local-running-services)
* [Custom URL](#custom-url)
  * [Running a local version of the frontend](#running-a-local-version-of-the-frontend)
  * [Running a local version of self service ops](#running-a-local-version-of-self-service-ops)
  * [Running a local version of user service backend](#running-a-local-version-of-user-service-backend)
  * [Running a local version of the stubs](#running-a-local-version-of-the-stubs)
  * [Changing custom URL](#changing-custom-url)
* [MongoDB](#mongodb)
  * [Adding data](#adding-data)
  * [Re-running the scripts](#re-running-the-scripts)
  * [Archives](#archives)
    * [Viewing the archives](#viewing-the-archives)
    * [Updating the archives](#updating-the-archives)
    * [Making the archives available](#making-the-archives-available)
* [Squid proxy](#squid-proxy)
* [Terminal](#terminal)

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

The mongodb instance is persisted to a volume called `cdp-infra-mongodb`. Redis and localstack are not persisted
between restarts.

## Starting a profile

> [!IMPORTANT]
> make sure you pull the latest images before starting the profile with `docker compose --profile portal pull`

```sh
$ docker compose --profile portal up
```

## Using with Portal tests

To run the [cdp-portal-tests](https://github.com/DEFRA/cdp-portal-tests) against this environment:

1. Pull the latest portal suite of docker images

```bash
$ docker compose --profile portal pull
```

1. Start the portal profile

```bash
docker compose --profile portal up
```

1. Then in another terminal:

```bash
cd cdp-portal-tests
npm run test
```

## Diagnosing issues

### Docker container logs

To see logs for a running container:

```bash
$ docker ps
$ docker logs <image-name>
```

To tail logs use:

```bash
$ docker logs <image-name> --follow
```

### Docker container information

To see detailed information about a running container:

```bash
$ docker inspect <image-name>
```

### Connect to Redis container

To have a look at the Redis data:

```bash
docker exec -it cdp-infra-redis redis-cli
```

### Connect to Mongo Docker

To have a look at the Mongo data:

```bash
mongosh cdp-infra-mongodb
````

## Mongo failing to connect issues

If you see the following error:

```bash
setup-cdp-portal-1    | 2024-08-22T07:49:39.636+0000	error connecting to host: failed to connect to mongodb://mongodb:27017: server selection error: server selection timeout, current topology: { Type: Single, Servers: [{ Addr: mongodb:27017, Type: Unknown, Last error: connection() error occurred during connection handshake: dial tcp: lookup mongodb on 127.0.0.11:53: no such host }, ] }
````

This may be because your volumes are full. This can be fixed by carefully removing old volumes:

```bash
docker system prune
````

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
|-----------------|---------------------------------------------------------------------------------|
| service-name    | actual service name (multiple places: section header, container_name, env_file) |
| image-name      | name of docker image, generally same as service-name                            |
| PORT            | a unique port number, not used by other services in the profile (nodejs only)   |
| ASPNETCORE_URLS | a unique port number, not used by other services in the profile (c# only)       |
| profile-name    | the same of the profile its part of                                             |

Next you'll need to create a new .env file for your service in `./config`. The file name should match the name defined
in the `env_file` section of the service definition.
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
      - { PROFILE }
```

The image `cdp-local-setup` contains a mongo, redis and localstack/aws client. On startup it runs all the scripts found
in `/scripts/*.sh`.

Next create a new folder in `./scripts/{SERVICE_NAME}` and place the init scripts into it. Everything in this folder
will be mounted into the cdp-service-init container at runtime.

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

### Running a local version of the frontend

When writing tests its handy to be able to change things in the `cdp-portal-fronted` and then tests the changes.

1. Start the portal services as described in the first 2 steps of [Using with Portal tests](#using-with-portal-tests)
1. Stop the Portal Frontend

```bash
docker compose stop cdp-portal-frontend
```

1. Start the Portal Frontend in development mode

> Note over time these environment variables may change, so check the latest in
> the [config/cdp-portal-frontend.env](config/cdp-portal-frontend.env).

```bash
NODE_ENV=development APP_BASE_URL=http://cdp.127.0.0.1.sslip.io:3000 USE_SINGLE_INSTANCE_CACHE=true PORTAL_BACKEND_URL=http://cdp.127.0.0.1.sslip.io:5094 SELF_SERVICE_OPS_URL=http://cdp.127.0.0.1.sslip.io:3009 USER_SERVICE_BACKEND_URL=http://cdp.127.0.0.1.sslip.io:3001 AZURE_CLIENT_SECRET=test_value OIDC_WELL_KNOWN_CONFIGURATION_URL=http://cdp.127.0.0.1.sslip.io:3939/6f504113-6b64-43f2-ade9-242e05780007/v2.0/.well-known/openid-configuration AZURE_TENANT_ID=6f504113-6b64-43f2-ade9-242e05780007 OIDC_AUDIENCE=26372ac9-d8f0-4da9-a17e-938eb3161d8e npm run dev:debug
````

1. Open your browser with [http://cdp.127.0.0.1.sslip.io:3000](http://cdp.127.0.0.1.sslip.io:3000)
1. You can now develop the frontend and run the tests against this and the rest of the services served via
   `cdp-local-environment`

### Running a local version of self service ops

1. Start the portal services as described in the first 2 steps of [Using with Portal tests](#using-with-portal-tests)
1. Stop Self Service Ops

```bash
docker compose stop cdp-self-service-ops
```

1. Start Self Service Ops in development mode

> Note over time these environment variables may change, so check the latest in
> the [config/cdp-self-service-ops.env](config/cdp-self-service-ops.env).

```bash
GITHUB_BASE_URL=http://cdp.127.0.0.1.sslip.io:3939 SQS_GITHUB_QUEUE=http://localstack:4566/000000000000/github-events USER_SERVICE_BACKEND_URL=http://cdp.127.0.0.1.sslip.io:3001 PORTAL_BACKEND_URL=http://cdp.127.0.0.1.sslip.io:5094 OIDC_WELL_KNOWN_CONFIGURATION_URL=http://cdp.127.0.0.1.sslip.io:3939/6f504113-6b64-43f2-ade9-242e05780007/v2.0/.well-known/openid-configuration npm run dev:debug
````

1. You can now develop Self Service Ops and run the tests against this and the rest of the services served via
   `cdp-local-environment`

### Running a local version of user service backend

1. Start the portal services as described in the first 2 steps of [Using with Portal tests](#using-with-portal-tests)
1. Stop User Service Backend

```bash
docker compose stop cdp-user-service-backend
```

1. Start User Service Backend in development mode

> Note over time these environment variables may change, so check the latest in
> the [config/cdp-user-service-backend.env](config/cdp-user-service-backend.env).

```bash
GITHUB_BASE_URL=http://cdp.127.0.0.1.sslip.io:3939 AZURE_CLIENT_BASE_URL=http://cdp.127.0.0.1.sslip.io:3939/msgraph/ OIDC_WELL_KNOWN_CONFIGURATION_URL=http://cdp.127.0.0.1.sslip.io:3939/6f504113-6b64-43f2-ade9-242e05780007/v2.0/.well-known/openid-configuration npm run dev:debug
````

1. You can now develop User Service Backend and run the tests against this and the rest of the services served via
   `cdp-local-environment`

### Running a local version of the stubs

When writing tests its handy to be able to change things in the `cdp-portal-stubs` and then tests the changes.

1. Start the portal services as described in the first 2 steps of [Using with Portal tests](#using-with-portal-tests)
1. Stop the Portal stubs

```bash
docker compose stop cdp-portal-stubs
```

1. Make sure any services you are testing that point to the stub have their envs updated to point to
   `http://host.docker.internal:3939`
1. Start the Portal stubs in development mode

> Note over time these environment variables may change, so check the latest in
> the [config/cdp-portal-stubs.env](config/cdp-portal-stubs.env).

```bash
OIDC_BASE_PATH=/6f504113-6b64-43f2-ade9-242e05780007/v2.0 OIDC_SHOW_LOGIN=false OIDC_PUBLIC_KEY_B64=LS0tLS1CRUdJTiBSU0EgUFVCTElDIEtFWS0tLS0tCk1JSUJDZ0tDQVFFQW1yamd3RENMMW9hb09BeWc2NmZlRHdwMDVHM2pETHJJWU4zcUxiVnZsNEFyQ1pCQkJrc3kKVlcwbmxoblZ5NmgwVVJITzJkcEtKcElFUjJEYSsyQ2ZmbWRCbDU2NDdnNTUzYUc5aWsvcVovUmRWb0FOSUo0dApBaHVhZUk0OGFhU2lSVGdOT0laczlBQTlPQXZPM1kwTCsyZmE4d1JzUnUvaTBwSTZqNnU3OG11WTJoNkl3UzJ0CjFEbjM4U0JFdzNRRktRUTV2c3d5eHA3VUtXdHNjdEs4MTk5NUN0VzJHNzJRQTJHQWsxMGs4L2ZMaExkaGQ1cksKR0FYeUsxeUk1YXpwckdZVm5Sa2VDem1mVE84aXBjSFJoVkVNeVFrRFRaVnJqeWRHcytqVm05d1poaWcrT1F5bwp3OUZ5ais4WGhxQXRnR0NBa1JlWFR2WlgrQ0VkYkxLMy9RSURBUUFCCi0tLS0tRU5EIFJTQSBQVUJMSUMgS0VZLS0tLS0K OIDC_PRIVATE_KEY_B64=LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb2dJQkFBS0NBUUVBbXJqZ3dEQ0wxb2FvT0F5ZzY2ZmVEd3AwNUczakRMcklZTjNxTGJWdmw0QXJDWkJCCkJrc3lWVzBubGhuVnk2aDBVUkhPMmRwS0pwSUVSMkRhKzJDZmZtZEJsNTY0N2c1NTNhRzlpay9xWi9SZFZvQU4KSUo0dEFodWFlSTQ4YWFTaVJUZ05PSVpzOUFBOU9Bdk8zWTBMKzJmYTh3UnNSdS9pMHBJNmo2dTc4bXVZMmg2SQp3UzJ0MURuMzhTQkV3M1FGS1FRNXZzd3l4cDdVS1d0c2N0SzgxOTk1Q3RXMkc3MlFBMkdBazEwazgvZkxoTGRoCmQ1cktHQVh5SzF5STVhenByR1lWblJrZUN6bWZUTzhpcGNIUmhWRU15UWtEVFpWcmp5ZEdzK2pWbTl3WmhpZysKT1F5b3c5RnlqKzhYaHFBdGdHQ0FrUmVYVHZaWCtDRWRiTEszL1FJREFRQUJBb0lCQUJmRjVlU3A0T2FrdUphcQpIQlN4YloxK2hCRHdNSFdOZ29uZHR5UndUeFhtYjladmw0b2x4alZaaVA1WGVHSHJQM29RWkNuVmtGU21WV2w1ClFKUmsxNFRXelQyRWVoSTczNjQxOHBkY3FaM3c3bUdDMmVHRDVGTUJWa1lGUnRPTnBCQkNLVWZnNGI5SkJSOEcKTTNJWHdMcFBqaFVPZml1Vkl0TXJmRHVFamVPVXR3cy9FR1ZLRzk4RTZkU1hWK3draUZlam1EOXFNdmV2VWNxKwpaUjlXMzlVZzZXTTgxUmd3ZHQ1NUQwZGVQRUdvYWppVnN3Q2RDZXZreklLYm4zNFd5MldDRE9yS0Q2OFduTjZsCms3dCt3ejJqTUxxeWJFa0psZVZYUk40dG5SM3JOZ3JJV21WNnU0RDFlR1hyYStzbk5SZWx4RkZOc0lQQTJyaDYKRWNKR2s2RUNnWUVBenBFUzRlOFJmRDFWcHloMWtHRnJ0VGF3aEhTL29BSDJxNjFBb3Y0MTdIR1JzWjdEN0FGSQpGdXBQTWFMV3d1TFlvMlhjR3I0ODE3U1p6WFBsZHROVXZaWmE4VTdCd1pRaGgyczMrS0o5OEh3N05xUVJtVXpyCjJtcTZDY3RQc0V6V2dVOGdmMStsTVZUQ3ZpUzdyOFVnUDVma20zVnRpNndoZXdLaWRBYnpyTjBDZ1lFQXY3K2wKV29GdVgvSEZUQ0FDSTZPbjZPMzJWV05vMnJFZi9RKzlzNTRxZnlMT2lCOUxORm04QTF4YXZNNDBOcnlVb2JLNQpKT1FxUGhsTUNYcUhxYVlqWWVSUmIvc09ud2w3cVlwcVZXQXFoVEUzZko4T0ZDN1lqLzVveFZ3YlM4VzVoa3JKClRZZ3JTUDZUVWNaMEo1U3RKTWZESDdMK0YxRzVTVnBUa2hVYWRhRUNnWUFVVVRTWVFGbHA3T1oxMElidnNvVlQKaDVPSkU2cWRaRlFNd3JldTBHNGhXWEpKRkNLVkhmTW5QZGlZT3pvQVpTdUZ0c2tWWUV5L3NxWEdEWFl1WDg3Zgo3dC8zQ0JZS29qVkNDb3V3eXRxMFFxUFlWZjdkSXpHM2cvUFVic2pod0UwQTN2V0ZVYlQveXlSMGEweUNsMUw2CnJrZnYrbmJSM0JaVzhRVmxnQ0dMaVFLQmdIOU9Cc05EQVh2VHNiRHI0MSswRFF1NXlYMUJoZUVFRGYvZWpvME4KS3B2RUNTa1kxYjVKQVdtZHpHUmo1d2ljUlhYaGljaHpiNVJSQ1VtVnZ6SWtLb09ZcVhUV1V3dkZxUU9UOFNzRApzTmRES05xbFl4eUZTYVM0UE9ralVNQUs0elRFdkVlc2EwaUlORmpya0R5akdoMDhQMUR4Ym44ZTlBdytXeE8yCnpSMWhBb0dBY0tYb01aaTFVK1h5dEpNWlhxUmE0R3hBc1pqRk5DZS9hNld6RGlnaXhtMnN4YXdVc09QeVlyU0EKZlRTV0pVZHkzaVVIV1BmdUtiQ2c4N1hUUVRHUUFXR0RUc3lMVXZ1TlVhQVpSMFZock12NGVxZS9IaEpoQ1V3agp6Z05vK0hHMDlYVytMWlM3S3BBbSsvYmRFZFJaQ3I4eEs4QXYwOFI2Z0FxNTIvWlZCTVU9Ci0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg== npm run dev
````

1. Stubs are now running on [http://host.docker.internal:3939](http://host.docker.internal:3939)
1. You can now develop the Portal stubs and run the tests against this and the rest of the services served via
   `cdp-local-environment`

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

## MongoDB

### Adding data

The first time the `cdp-infra-mongodb` mongo image is built, it will run any scripts found in `/scripts/mongodb`. Any
files found in the `/scripts/mongodb` directory will be run in alphabetical order in a mongo shell.

Mongo shell methods and helpers available to these scripts are https://www.mongodb.com/docs/manual/reference/method/

#### Re-running the scripts

These scripts will only be ran when there is nothing in the containers `/data/db` directory. To re-run these scripts:

1. `Docker compose down` to stop the containers
1. `Docker volume rm cdp-local-environment_cdp-infra-mongodb-data` to remove the volume
1. `Docker compose up` to start the containers

### Archives

> [!IMPORTANT]
> *DEPRECATED* The way to add MongoDb data is documented
> in [Adding data](#adding-data). These archives are still in
> use but should not be used to add new data. At some point they will be ported over to the new way of adding mongo mock
> data.

#### Viewing the archives

First of all insert the MongoDB archives found in [scripts/portal](scripts/portal) into your local MongoDB so you can
see the data.

> [!IMPORTANT]
> Backup your local MongoDB data before running the following command.

```bash
mongorestore --host="127.0.0.1:27017" --gzip --archive=cdp-user-service-backend.archive --drop
mongorestore --host="127.0.0.1:27017" --gzip --archive=cdp-portal-backend.archive --drop
```

#### Updating the archives

Make changes to the MongoDB database collections in Compass/MongoDB locally. Then run the following command to export as
an archive.

```bash
mongodump --host="127.0.0.1:27017" -d=cdp-user-service-backend --gzip --archive=cdp-user-service-backend.archive
mongodump --host="127.0.0.1:27017" -d=cdp-portal-backend --gzip --archive=cdp-portal-backend.archive
```

#### Making the archives available

To allow `cdp-local-environment` to use the data in the archives. Add the following command
to [scripts/portal/setup-mongo.sh](scripts/portal/setup-mongo.sh)

E.g

```bash
mongorestore --uri=mongodb://mongodb:27017 --gzip --archive=/scripts/cdp-user-service-backend.archive --drop
mongorestore --uri=mongodb://mongodb:27017 --gzip --archive=/scripts/cdp-portal-backend.archive --drop
```

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

## Terminal

1. Build a Docker image of https://github.com/DEFRA/cdp-webshell with the tag `defradigital/cdp-webshell`

   ```bash
   cd ../cdp-webshell;
   docker build -tag defradigital/cdp-webshell .
   ```

1. Build a Docker image of https://github.com/DEFRA/cdp-webshell-proxy with the tag `defradigital/cdp-webshell-proxy`

   ```bash
   cd ../cdp-webshell-proxy;
   docker build -tag defradigital/cdp-webshell-proxy .
   ```
1. Launch as `terminal` profile

   ```bash
   cd ../cdp-local-environment;
   docker compose --profile terminal up -d
   ```
