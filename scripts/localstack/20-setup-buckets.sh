#!/bin/bash
echo Setting up Portal Buckets

source /etc/localstack/conf.d/local-defaults.env

aws --endpoint-url=$LOCALSTACK_URL s3 --region $AWS_REGION mb s3://my-bucket
aws --endpoint-url=$LOCALSTACK_URL s3 --region $AWS_REGION mb s3://cdp-uploader-quarantine
aws --endpoint-url=$LOCALSTACK_URL s3 --region $AWS_REGION mb s3://cdp-example-node-frontend
aws --endpoint-url=$LOCALSTACK_URL s3 --region $AWS_REGION mb s3://cdp-documentation

echo Done!

aws --endpoint $LOCALSTACK_URL s3api --region $AWS_REGION list-buckets
