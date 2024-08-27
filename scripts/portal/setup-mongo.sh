#!/bin/bash

mongorestore --uri=mongodb://mongodb:27017 --gzip --archive=/scripts/cdp-user-service-backend.archive --drop
mongorestore --uri=mongodb://mongodb:27017 --gzip --db=cdp-portal-backend --archive=/scripts/cdp-portal-backend.archive --drop
