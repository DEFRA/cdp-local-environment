db = db.getSiblingDB("cdp-portal-backend");

db.featuretoggles.updateOne(
  {
    "_id": "disable-create-service"
  },
  {
    $setOnInsert: {
      "_id": "disable-create-service",
      "name": "Disable create service",
      "url": "/create",
      "active": false
    }
  }
);
db.featuretoggles.updateOne(
  {
    "_id": "disable-start-decommissions"
  },
  {
    $setOnInsert: {
      "_id": "disable-start-decommissions",
      "name": "Disable Decommissions",
      "url": "/admin/decommissions/start",
      "active": false
    }
  }
);
db.featuretoggles.updateOne(
  {
    "_id": "disable-prototypes"
  },
  {
    $setOnInsert: {
      "_id": "disable-prototypes",
      "name": "Disable Prototypes",
      "url": "/create/prototype",
      "active": false
    }
  }
);
