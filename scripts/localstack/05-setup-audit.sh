#!/bin/bash
echo Setting up Audit Stream

source /etc/localstack/conf.d/local-defaults.env

aws --endpoint $LOCALSTACK_URL firehose create-delivery-stream --delivery-stream-name cdp-firehose-audit --region $AWS_REGION
