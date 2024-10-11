#!/bin/bash

echo Setting up Portal Buckets Notifications

source /etc/localstack/conf.d/local-defaults.env

aws --endpoint-url=$LOCALSTACK_URL s3api put-bucket-notification-configuration \
    --bucket cdp-uploader-quarantine --region $AWS_REGION \
    --notification-configuration '{
                                      "QueueConfigurations": [
                                         {
                                           "QueueArn": "arn:aws:sqs:eu-west-2:000000000000:mock-clamav",
                                           "Events": ["s3:ObjectCreated:*"]
                                         }
                                       ]
	                                }'


echo Done!

aws --endpoint-url=$LOCALSTACK_URL s3api get-bucket-notification-configuration \
    --bucket cdp-uploader-quarantine --region $AWS_REGION
