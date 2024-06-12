#!/bin/sh
echo Setting up Audit Stream
aws --endpoint $LOCALSTACK_URL firehose create-delivery-stream --delivery-stream-name cdp-firehose-audit

