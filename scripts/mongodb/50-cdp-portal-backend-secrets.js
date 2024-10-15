db = db.getSiblingDB("cdp-portal-backend");

// db.createCollection("tenantsecrets");

db.tenantsecrets.insertMany([
  {
    _id: BSON.ObjectId("670e925aed103e51a180954b"),
    environment: "management",
    service: "cdp-portal-frontend",
    keys: ["SOME_KEY"],
    lastChangedDate: "2024-10-15T16:03:38.3139986Z",
  },
]);

// db.tenantsecrets.insertMany([
//   {
//     _id: {
//       $oid: "670e925aed103e51a180954b",
//     },
//     environment: "management",
//     service: "cdp-portal-frontend",
//     keys: ["SOME_KEY"],
//     lastChangedDate: "2024-10-15T16:03:38.3139986Z",
//   },
//   {
//     _id: {
//       $oid: "670e925aed103e51a1809550",
//     },
//     environment: "infra-dev",
//     service: "cdp-self-service-ops",
//     keys: ["SOME_KEY"],
//     lastChangedDate: "2024-10-15T16:03:38.8082148Z",
//   },
//   {
//     _id: {
//       $oid: "670e925bed103e51a1809555",
//     },
//     environment: "management",
//     service: "cdp-self-service-ops",
//     keys: ["SOME_KEY"],
//     lastChangedDate: "2024-10-15T16:03:39.5206321Z",
//   },
// ]);
