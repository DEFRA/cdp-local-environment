db = db.getSiblingDB("cdp-user-service-backend");

db.users.updateOne(
  {
    name: "Test, User",
    email: "test.user@oidc.mock",
    github: "testuser",
  },
  {
    $setOnInsert: {
      _id: "90552794-0613-4023-819a-512aa9d40023",
      name: "Test, User",
      email: "test.user@oidc.mock",
      github: "testuser",
      createdAt: {
        $date: "2023-10-26T12:51:00.028Z",
      },
      updatedAt: {
        $date: "2023-10-26T12:51:00.028Z",
      },
      teams: ["aabe63e7-87ef-4beb-a596-c810631fc474"],
    },
  },
  { upsert: true }
);
