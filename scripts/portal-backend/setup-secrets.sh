#!/bin/sh
echo Setting up Secrets

## Temporary solution to add secrets until proper service scaffold in stubs

export PORTAL_BACKEND_URL="http://cdp-portal-backend:5094"

curl -H "Content-Type: application/json" -d \
   '{"environment":"infra-dev", "service": "cdp-portal-frontend","secretKey":"SOME_KEY","action":"add_secret"}' \
   $PORTAL_BACKEND_URL/secrets/register/pending

aws --endpoint $LOCALSTACK_URL sqs send-message --queue-url \
  "$LOCALSTACK_URL/000000000000/secret_management_updates" \
  --region $AWS_REGION --message-body \
  '{"source": "cdp-secret-manager-lambda", "statusCode": 200, "action": "add_secret", "body": {"add_secret": true, "secret": "cdp/services/cdp-portal-frontend",  "environment": "infra-dev", "secret_key": "SOME_KEY" }}'

curl -H "Content-Type: application/json" -d \
   '{"environment":"management", "service": "cdp-portal-frontend","secretKey":"SOME_KEY","action":"add_secret"}' \
  $PORTAL_BACKEND_URL/secrets/register/pending

aws --endpoint $LOCALSTACK_URL sqs send-message --queue-url \
  "$LOCALSTACK_URL/000000000000/secret_management_updates" \
  --region $AWS_REGION --message-body \
  '{"source": "cdp-secret-manager-lambda", "statusCode": 200, "action": "add_secret", "body": {"add_secret": true, "secret": "cdp/services/cdp-portal-frontend",  "environment": "management", "secret_key": "SOME_KEY" }}'

curl -H "Content-Type: application/json" -d \
   '{"environment":"infra-dev", "service": "cdp-self-service-ops","secretKey":"SOME_KEY","action":"add_secret"}' \
   $PORTAL_BACKEND_URL/secrets/register/pending

aws --endpoint $LOCALSTACK_URL sqs send-message --queue-url \
  "$LOCALSTACK_URL/000000000000/secret_management_updates" \
  --region $AWS_REGION --message-body \
  '{"source": "cdp-secret-manager-lambda", "statusCode": 200, "action": "add_secret", "body": {"add_secret": true, "secret": "cdp/services/cdp-self-service-ops",  "environment": "infra-dev", "secret_key": "SOME_KEY" }}'

curl -H "Content-Type: application/json" -d \
   '{"environment":"management", "service": "cdp-self-service-ops","secretKey":"SOME_KEY","action":"add_secret"}' \
   $PORTAL_BACKEND_URL/secrets/register/pending

aws --endpoint $LOCALSTACK_URL sqs send-message --queue-url \
  "$LOCALSTACK_URL/000000000000/secret_management_updates" \
  --region $AWS_REGION --message-body \
  '{"source": "cdp-secret-manager-lambda", "statusCode": 200, "action": "add_secret", "body": {"add_secret": true, "secret": "cdp/services/cdp-self-service-ops",  "environment": "management", "secret_key": "SOME_KEY" }}'
