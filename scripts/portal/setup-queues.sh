#!/bin/sh
echo Setting up Portal Queues
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name ecs-deployments
aws --endpoint $LOCALSTACK_URL sqs create-queue --queue-name ecr-push-events
echo Done!
aws --endpoint $LOCALSTACK_URL sqs list-queues

