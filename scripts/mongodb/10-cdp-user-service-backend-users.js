db = db.getSiblingDB("cdp-user-service-backend");

db.users.updateOne(
  {
    name: "Admin User",
    email: "admin.user@oidc.mock",
    github: "adminuser",
  },
  {
    $setOnInsert: {
      _id: "90552794-0613-4023-819a-512aa9d40023",
      name: "Admin User",
      email: "admin.user@oidc.mock",
      github: "adminuser",
      createdAt: "2023-10-26T12:51:00.028Z",
      updatedAt: "2023-10-26T12:51:00.028Z",
      teams: ["aabe63e7-87ef-4beb-a596-c810631fc474"],
      scopes: [
        new ObjectId("6750708d454fcbbcc1568154")
      ],
    },
  },
  { upsert: true }
);

db.users.updateOne(
  {
    name: "Non-Admin User",
    email: "nonadmin.user@oidc.mock",
    github: "nonadminuser",
  },
  {
    $setOnInsert: {
      _id: "dfa791eb-76b2-434c-ad1f-bb9dc1dd8b48",
      name: "Non-Admin User",
      email: "non-admin.user@oidc.mock",
      github: "nonadminuser",
      createdAt: "2024-11-11T13:51:00.028Z",
      updatedAt: "2024-11-12T13:24:00.028Z",
      teams: ["44c7fa74-40e7-470d-a18a-b78a60bbef8e"],
      scopes:[]
    },
  },
  { upsert: true }
);
