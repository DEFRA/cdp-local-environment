#!/bin/sh
echo Setting up Portal Queues
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name ecs-deployments
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name ecr-push-events
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name github-events

# stub-deployments is used only by cdp-portal-stubs to simulate deployments
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name deployments-from-portal
aws --endpoint $LOCALSTACK_URL sns create-topic --name deploy-topic
aws --endpoint $LOCALSTACK_URL sns subscribe --topic-arn arn:aws:sns:$AWS_REGION:000000000000:deploy-topic --protocol sqs --notification-endpoint  arn:aws:sqs:eu-west-2:000000000000:deployments-from-portal

echo Done!
aws --endpoint $LOCALSTACK_URL sqs list-queues
aws --endpoint $LOCALSTACK_URL sns list-topics

