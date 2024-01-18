#!/bin/bash

#mongorestore --uri=mongodb://localhost:27017 --gzip --archive=/scripts/portal.archive --drop
# mongorestore --uri=mongodb://localhost:27017 --gzip --archive=/scripts/cdp-user-service-backend.archive --drop

mongorestore --uri=mongodb://mongodb:27017 --gzip --archive=/scripts/cdp-user-service-backend.archive --drop
