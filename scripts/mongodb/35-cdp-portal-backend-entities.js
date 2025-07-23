db = db.getSiblingDB("cdp-portal-backend");

db.entities.updateOne(
  {
    name: "cdp-portal-backend"
  },
  {
    $setOnInsert: {
      "type": "Microservice",
      "subType": "Backend",
      "name": "cdp-portal-backend",
      "created": "2016-12-05T11:21:25.000Z",
      "status": "Created",
      "teams": [
        {
          "teamId": "aabe63e7-87ef-4beb-a596-c810631fc474",
          "name": "Platform"
        }
      ]
    },
  },
  { upsert: true }
);

db.entities.updateOne(
  {
    name: "cdp-portal-frontend"
  },
  {
    $setOnInsert: {
      "type": "Microservice",
      "subType": "Frontend",
      "name": "cdp-portal-frontend",
      "created": "2016-12-05T11:21:25.000Z",
      "status": "Created",
      "teams": [
        {
          "teamId": "aabe63e7-87ef-4beb-a596-c810631fc474",
          "name": "Platform"
        }
      ]
    },
  },
  { upsert: true }
);

db.entities.updateOne(
  {
    name: "cdp-self-service-ops"
  },
  {
    $setOnInsert: {
      "type": "Microservice",
      "subType": "Backend",
      "name": "cdp-self-service-ops",
      "created": "2016-12-05T11:21:25.000Z",
      "status": "Created",
      "teams": [
        {
          "teamId": "aabe63e7-87ef-4beb-a596-c810631fc474",
          "name": "Platform"
        }
      ]
    },
  },
  { upsert: true }
);

db.entities.updateOne(
  {
    name: "cdp-env-test-suite"
  },
  {
    $setOnInsert: {
      "type": "TestSuite",
      "subType": "Journey",
      "name": "cdp-env-test-suite",
      "created": "2016-12-05T11:21:25.000Z",
      "status": "Created",
      "teams": [
        {
          "teamId": "aabe63e7-87ef-4beb-a596-c810631fc474",
          "name": "Platform"
        }
      ]
    },
  },
  { upsert: true }
);

db.entities.updateOne(
  {
    name: "cdp-postgres-service"
  },
  {
    $setOnInsert: {
      "type": "Microservice",
      "subType": "Backend",
      "name": "cdp-postgres-service",
      "created": "2016-12-05T11:21:25.000Z",
      "status": "Created",
      "teams": [
        {
          "teamId": "aabe63e7-87ef-4beb-a596-c810631fc474",
          "name": "Platform"
        }
      ]
    },
  },
  { upsert: true }
);

db.entities.updateOne(
  {
    name: "tenant-backend"
  },
  {
    $setOnInsert: {
      "type": "Microservice",
      "subType": "Backend",
      "name": "tenant-backend",
      "created": "2016-12-05T11:21:25.000Z",
      "status": "Created",
      "teams": [
        {
          "teamId": "44c7fa74-40e7-470d-a18a-b78a60bbef8e",
          "name": "TenantTeam1"
        }
      ]
    },
  },
  { upsert: true }
);

db.entities.updateOne(
  {
    name: "cdp-service-prototype"
  },
  {
    $setOnInsert: {
      "type": "Prototype",
      "name": "cdp-service-prototype",
      "created": "2024-12-05T11:21:25.000Z",
      "status": "Success",
      "teams": [
        {
          "teamId": "aabe63e7-87ef-4beb-a596-c810631fc474",
          "name": "Platform"
        }
      ]
    },
  },
  { upsert: true }
);


