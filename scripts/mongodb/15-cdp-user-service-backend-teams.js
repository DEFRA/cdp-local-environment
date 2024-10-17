db = db.getSiblingDB("cdp-user-service-backend");

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
      createdAt: {
        $date: "2023-10-26T12:51:00.028Z",
      },
      updatedAt: {
        $date: "2023-10-26T12:51:00.028Z",
      },
    },
  },
  { upsert: true }
);
