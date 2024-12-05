db = db.getSiblingDB("cdp-user-service-backend");

db.scopes.updateOne(
  {
    value: "externalTest"
  },
  {
    $setOnInsert: {
      _id: new ObjectId("674def9d30093e3a3aa49d35"),
      userId: "90552794-0613-4023-819a-512aa9d40023",
      value: "externalTest",
      teams: [
        "aabe63e7-87ef-4beb-a596-c810631fc474"
      ],
      createdAt: "2024-12-02T17:34:21.295Z",
      updatedAt: "2024-12-02T17:34:21.295Z"
    },
  },
  { upsert: true }
);

db.scopes.updateOne(
  {
    value: "breakglass"
  },
  {
    $setOnInsert: {
      _id: new ObjectId("6750708d454fcbbcc1568154"),
      userId: "90552794-0613-4023-819a-512aa9d40023",
      value: "breakglass",
      teams: [
      ],
      createdAt: "2024-12-02T17:34:21.295Z",
      updatedAt: "2024-12-02T17:34:21.295Z"
    },

  },
  { upsert: true }
);


db.teams.updateOne(
  {
    name: "Platform",
  },
  {
    $setOnInsert: {
      _id: "aabe63e7-87ef-4beb-a596-c810631fc474",
      name: "Platform",
      description: "The team that runs the platform",
      github: "cdp-platform",
      users: ["90552794-0613-4023-819a-512aa9d40023"],
      scopes: [
        new ObjectId("674def9d30093e3a3aa49d35")
      ],
      createdAt: "2023-10-26T12:51:00.028Z",
      updatedAt: "2023-10-26T12:51:00.028Z",
    },
  },
  { upsert: true }
);

db.teams.updateOne(
  {
    name: "TenantTeam1",
  },
  {
    $setOnInsert: {
      _id: "44c7fa74-40e7-470d-a18a-b78a60bbef8e",
      name: "TenantTeam1",
      description: "A test team",
      github: "cdp-tenant-1",
      users: [],
      scopes: [],
      createdAt: "2024-10-26T12:51:00.028Z",
      updatedAt: "2024-10-26T12:55:00.028Z",
    },
  },
  { upsert: true }
);
