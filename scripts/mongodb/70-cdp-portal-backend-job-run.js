db = db.getSiblingDB("cdp-portal-backend");

db.testruns.updateOne(
  {
    environment: "infra-dev",
    testSuite: "cdp-env-test-suite",
    runId: "3ec0b267-e513-4dd1-a525-8a3a798a9c4b",
  },
  {
    $setOnInsert: {
      runId: "3ec0b267-e513-4dd1-a525-8a3a798a9c4b",
      environment: "infra-dev",
      testSuite: "cdp-env-test-suite",
      created: "2023-11-01T12:59:56.102Z",
      user: {
        _id: "90552794-0613-4023-819a-512aa9d40023",
        displayName: "Test, User",
      },
      taskArn:
        "arn:aws:ecs:eu-west-2:12334656:task/infra-dev-ecs-public/19abc1234564a009128875ffa6b9047",
      taskLastUpdate: "2023-11-01T12:59:56.102Z",
      taskStatus: "finished",
      testStatus: "passed",
      tag: "0.11.0",
    },
  },
  { upsert: true }
);
