db = db.getSiblingDB("cdp-portal-backend");

// db.createCollection("tenantsecrets");

db.tenantsecrets.updateOne(
  {
    environment: "infra-dev",
    service: "cdp-portal-frontend",
    keys: ["SOME_KEY"],
  },
  {
    $setOnInsert: {
      environment: "infra-dev",
      service: "cdp-portal-frontend",
      keys: ["SOME_KEY"],
      lastChangedDate: "2024-10-15T16:03:38.3139986Z",
    },
  },
  { upsert: true }
);

db.tenantsecrets.updateOne(
  {
    environment: "management",
    service: "cdp-portal-frontend",
    keys: ["SOME_KEY"],
  },
  {
    $setOnInsert: {
      environment: "management",
      service: "cdp-portal-frontend",
      keys: ["SOME_KEY"],
      lastChangedDate: "2024-10-15T16:03:38.3139986Z",
    },
  },
  { upsert: true }
);

db.tenantsecrets.updateOne(
  {
    environment: "infra-dev",
    service: "cdp-self-service-ops",
    keys: ["SOME_KEY"],
  },
  {
    $setOnInsert: {
      environment: "infra-dev",
      service: "cdp-self-service-ops",
      keys: ["SOME_KEY"],
      lastChangedDate: "2024-10-15T16:03:38.8082148Z",
    },
  },
  { upsert: true }
);

db.tenantsecrets.updateOne(
  {
    environment: "management",
    service: "cdp-self-service-ops",
    keys: ["SOME_KEY"],
  },
  {
    $setOnInsert: {
      environment: "management",
      service: "cdp-self-service-ops",
      keys: ["SOME_KEY"],
      lastChangedDate: "2024-10-15T16:03:39.5206321Z",
    },
  },
  { upsert: true }
);
