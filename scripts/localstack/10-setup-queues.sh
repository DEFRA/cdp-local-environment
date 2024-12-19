#!/bin/bash
echo Setting up Portal Queues

source /etc/localstack/conf.d/local-defaults.env

aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name ecs-deployments
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name ecr-push-events
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name github-events

aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name cdp_workflow_events
aws --endpoint http://localhost:4566 sns create-topic --name cdp_workflow_events
aws --endpoint http://localhost:4566 sns subscribe --topic-arn arn:aws:sns:eu-west-2:000000000000:cdp_workflow_events --protocol sqs --notification-endpoint arn:aws:sqs:eu-west-2:000000000000:cdp_workflow_events
#aws --endpoint http://localhost:4566 set-subscription-attributes --subscription-arn arn:aws:sns:eu-west-2:000000000000:cdp_workflow_events:85502ec3-9ea1-429d-99be-682f2fcbb895 --attribute-name RawMessageDelivery --attribute-value true

aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name deployments-from-portal
aws --endpoint $LOCALSTACK_URL sns create-topic --region $AWS_REGION --name deploy-topic
aws --endpoint $LOCALSTACK_URL sns subscribe --region $AWS_REGION --topic-arn arn:aws:sns:$AWS_REGION:000000000000:deploy-topic --protocol sqs --notification-endpoint  arn:aws:sqs:$AWS_REGION:000000000000:deployments-from-portal

aws --endpoint $LOCALSTACK_URL sns create-topic --region $AWS_REGION --name cdp-notification
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name cdp-notification
aws --endpoint $LOCALSTACK_URL sns subscribe --region $AWS_REGION --topic-arn arn:aws:sns:$AWS_REGION:000000000000:cdp-notification --protocol sqs --notification-endpoint  arn:aws:sqs:$AWS_REGION:000000000000:cdp-notification

echo Setting up Secrets and Secret Manager lambda
aws --endpoint $LOCALSTACK_URL sns create-topic --region $AWS_REGION --name secret_management
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name secret_management_updates
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name secret_management_updates_lambda
aws --endpoint $LOCALSTACK_URL sns subscribe --region $AWS_REGION --topic-arn arn:aws:sns:$AWS_REGION:000000000000:secret_management --protocol sqs --notification-endpoint  arn:aws:sqs:$AWS_REGION:000000000000:secret_management_updates
aws --endpoint $LOCALSTACK_URL sns subscribe --region $AWS_REGION --topic-arn arn:aws:sns:$AWS_REGION:000000000000:secret_management --protocol sqs --notification-endpoint  arn:aws:sqs:$AWS_REGION:000000000000:secret_management_updates_lambda

echo Setting up Uploader
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name cdp-clamav-results
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name cdp-uploader-scan-results-callback.fifo --attributes "{\"FifoQueue\":\"true\"}"
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name mock-clamav

echo Setting up CDP Notify
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name cdp_grafana_alerts

echo Setting up stub test suite runs
aws --endpoint $LOCALSTACK_URL sqs create-queue --region $AWS_REGION --queue-name run-test-from-portal
aws --endpoint $LOCALSTACK_URL sns create-topic --region $AWS_REGION --name run-test-topic
aws --endpoint $LOCALSTACK_URL sns subscribe --region $AWS_REGION --topic-arn arn:aws:sns:$AWS_REGION:000000000000:run-test-topic --protocol sqs --notification-endpoint  arn:aws:sqs:$AWS_REGION:000000000000:run-test-from-portal

echo Setting up webshell queues
aws --endpoint $LOCALSTACK_URL sns create-topic --region $AWS_REGION --name run-webshell-topic

echo Done!

aws --endpoint $LOCALSTACK_URL sqs --region $AWS_REGION list-queues
aws --endpoint $LOCALSTACK_URL sns --region $AWS_REGION list-topics
