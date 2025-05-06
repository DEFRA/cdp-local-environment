#!/bin/sh

DIRECTORY="$PWD/assets"

echo "Pushing migrations to S3"

if [ -d "$DIRECTORY" ]; then
  aws --endpoint-url=$LOCALSTACK_URL s3 --region $AWS_REGION cp "${DIRECTORY}/migrations.tgz" s3://cdp-migrations/cdp-postgres-service/0.1.0/
  aws --endpoint-url=$LOCALSTACK_URL s3 --region $AWS_REGION cp "${DIRECTORY}/migrations.tgz" s3://cdp-migrations/cdp-postgres-service/0.2.0/

  echo "Migrations pushed"
else
  echo "$DIRECTORY is not found"
  exit 1
fi
