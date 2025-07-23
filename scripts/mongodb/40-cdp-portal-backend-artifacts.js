db = db.getSiblingDB("cdp-portal-backend");

db.artifacts.updateOne(
  {
    repo: "cdp-self-service-ops",
    tag: "0.100.0",
  },
  {
    $setOnInsert: {
      created: "2023-11-02T16:24:06.004Z",
      repo: "cdp-self-service-ops",
      tag: "0.100.0",
      sha256:
        "sha256:f2b8d79f6d70fd88b6bfce2d1bd5572ced3a8f64b5cc9537223f845665c240e5",
      githubUrl: "https://github.com/DEFRA/cdp-self-service-ops",
      serviceName: "cdp-self-service-ops",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(6553600),
      runMode: "service",
    },
  },
  { upsert: true }
);

db.artifacts.updateOne(
  {
    repo: "cdp-self-service-ops",
    tag: "0.101.0",
  },
  {
    $setOnInsert: {
      created: "2023-11-03T13:16:58.099Z",
      repo: "cdp-self-service-ops",
      tag: "0.101.0",
      sha256:
        "sha256:6330e8011f202c62de51f36f1af5a6b53868b492c3886922cbc3fa8cc4952022",
      githubUrl: "https://github.com/DEFRA/cdp-self-service-ops",
      serviceName: "cdp-self-service-ops",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(6619136),
      runMode: "service",
    },
  },
  { upsert: true }
);

db.artifacts.updateOne(
  {
    repo: "cdp-self-service-ops",
    tag: "0.102.0",
  },
  {
    $setOnInsert: {
      created: "2023-11-03T16:12:39.603Z",
      repo: "cdp-self-service-ops",
      tag: "0.102.0",
      sha256:
        "sha256:917c98d3c87bdefe6b8b0b223127d59299d8fb9af51b93c072250d4b86225001",
      githubUrl: "https://github.com/DEFRA/cdp-self-service-ops",
      serviceName: "cdp-self-service-ops",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(6684672),
      runMode: "service",
    },
  },
  { upsert: true }
);

db.artifacts.updateOne(
  {
    repo: "cdp-portal-frontend",
    tag: "0.170.0",
  },
  {
    $setOnInsert: {
      created: "2023-11-01T10:43:15.125Z",
      repo: "cdp-portal-frontend",
      tag: "0.170.0",
      sha256:
        "sha256:3f1827d215e5c0a3f36c1d6f9df303431f30cc81cc8f6d1507194c165410a450",
      githubUrl: "https://github.com/DEFRA/cdp-portal-frontend",
      serviceName: "cdp-portal-frontend",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(11141120),
      runMode: "service",
    },
  },
  { upsert: true }
);

db.artifacts.updateOne(
  {
    repo: "cdp-portal-frontend",
    tag: "0.171.0",
  },
  {
    $setOnInsert: {
      created: "2023-11-01T12:27:57.452Z",
      repo: "cdp-portal-frontend",
      tag: "0.171.0",
      sha256:
        "sha256:9f59b194a343121c3ad6494cc475400419c29949e0910ada66351c3864a31e94",
      githubUrl: "https://github.com/DEFRA/cdp-portal-frontend",
      serviceName: "cdp-portal-frontend",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(11206656),
      runMode: "service",
    },
  },
  { upsert: true }
);

db.artifacts.updateOne(
  {
    repo: "cdp-portal-frontend",
    tag: "0.172.0",
  },
  {
    $setOnInsert: {
      created: "2023-11-01T12:59:56.102Z",
      repo: "cdp-portal-frontend",
      tag: "0.172.0",
      sha256:
        "sha256:281e045fe5f07016cbe3092984c6bee5095fea778b7f6ade5c53bfc99cdc448e",
      githubUrl: "https://github.com/DEFRA/cdp-portal-frontend",
      serviceName: "cdp-portal-frontend",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(11272192),
      runMode: "service",
    },
  },
  { upsert: true }
);

db.artifacts.updateOne(
  {
    repo: "cdp-env-test-suite",
    tag: "0.11.0",
  },
  {
    $setOnInsert: {
      created: "2023-11-01T12:59:56.102Z",
      repo: "cdp-env-test-suite",
      tag: "0.11.0",
      sha256:
        "sha256:281e045fe5f07016cbe3092984c6bee5095fea778b7f6ade5c53bfc99cdc448e",
      githubUrl: "https://github.com/DEFRA/cdp-env-test-suite",
      serviceName: "cdp-env-test-suite",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(11272192),
      runMode: "job",
    },
  },
  { upsert: true }
);

db.artifacts.updateOne(
  {
    repo: "cdp-postgres-service",
    tag: "0.100.0",
  },
  {
    $setOnInsert: {
      created: "2023-11-02T16:24:06.004Z",
      repo: "cdp-postgres-service",
      tag: "0.100.0",
      sha256:
        "sha256:f2b8d79f6d70fd88b6bfce2d1bd5572ced3a8f64b5cc9537223f845665c240e5",
      githubUrl: "https://github.com/DEFRA/cdp-postgres-service",
      serviceName: "cdp-postgres-service",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(6553600),
      runMode: "service",
    },
  },
  { upsert: true }
);

db.artifacts.updateOne(
  {
    repo: "cdp-service-prototype",
    tag: "0.1.0",
  },
  {
    $setOnInsert: {
      created: "2024-11-02T16:24:06.004Z",
      repo: "cdp-service-prototype",
      tag: "0.1.0",
      sha256:
        "sha256:f2b8d79f6d70fd88b6bfce2d1bd5572ced3a8f64b5cc9537223f845665c2405e",
      githubUrl: "https://github.com/DEFRA/cdp-service-prototype",
      serviceName: "cdp-service-prototype",
      scannerVersion: 1,
      teams: [
        {
          github: "cdp-platform",
          teamId: "aabe63e7-87ef-4beb-a596-c810631fc474",
          name: "Platform",
        },
      ],
      files: [],
      semVer: Long(6553600),
      runMode: "service",
    },
  },
  { upsert: true }
);
