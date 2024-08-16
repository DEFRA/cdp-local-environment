#!/bin/sh
echo Setting up Portal Queues
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name ecs-deployments
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name ecr-push-events
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name github-events

aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name deployments-from-portal
aws --endpoint $LOCALSTACK_URL sns create-topic --name deploy-topic
aws --endpoint $LOCALSTACK_URL sns subscribe --topic-arn arn:aws:sns:$AWS_REGION:000000000000:deploy-topic --protocol sqs --notification-endpoint  arn:aws:sqs:eu-west-2:000000000000:deployments-from-portal

# secret manager create secrets
aws --endpoint $LOCALSTACK_URL sns create-topic --name secret_management
# secret manager results
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name secret_management_updates

echo Setting up Uploader
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name cdp-clamav-results
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name cdp-uploader-scan-results-callback.fifo --attributes "{\"FifoQueue\":\"true\"}"
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name mock-clamav

aws --endpoint-url=$LOCALSTACK_URL s3 mb s3://my-bucket
aws --endpoint-url=$LOCALSTACK_URL s3 mb s3://cdp-uploader-quarantine
aws --endpoint-url=$LOCALSTACK_URL s3 mb s3://cdp-example-node-frontend

aws --endpoint-url=$LOCALSTACK_URL s3api put-bucket-notification-configuration\
    --bucket cdp-uploader-quarantine \
    --notification-configuration '{
                                      "QueueConfigurations": [
                                         {
                                           "QueueArn": "arn:aws:sqs:eu-west-2:000000000000:mock-clamav",
                                           "Events": ["s3:ObjectCreated:*"]
                                         }
                                       ]
	                                }'


# stub test suite runs
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name run-test-from-portal
aws --endpoint $LOCALSTACK_URL sns create-topic --name run-test-topic
aws --endpoint $LOCALSTACK_URL sns subscribe --topic-arn arn:aws:sns:$AWS_REGION:000000000000:run-test-topic --protocol sqs --notification-endpoint  arn:aws:sqs:eu-west-2:000000000000:run-test-from-portal

echo Done!
aws --endpoint $LOCALSTACK_URL sqs list-queues
aws --endpoint $LOCALSTACK_URL sns list-topics
