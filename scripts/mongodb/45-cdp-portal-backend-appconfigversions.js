db = db.getSiblingDB("cdp-portal-backend");

db.appconfigversions.updateOne(
    {
        _id: '673727ce322164747330238a',
    },
    {
        $setOnInsert: {
            _id: '673727ce322164747330238a',
            commitSha: 'abc123',
            commitTimestamp: ISODate('2024-10-05T16:10:10.123Z'),
            environment: 'management'

        },
    },
    {upsert: true}
);

db.appconfigversions.updateOne(
    {
        _id: '673728a6322164747330238b',
    },
    {
        $setOnInsert: {
            _id: '673728a6322164747330238b',
            commitSha: 'abc123',
            commitTimestamp: ISODate('2024-10-05T16:10:10.123Z'),
            environment: 'management'

        },
    },
    {upsert: true}
);

db.appconfigversions.updateOne(
    {
        _id: '673728a6322164747330238c',
    },
    {
        $setOnInsert: {
            _id: '673728a6322164747330238c',
            commitSha: 'abc123',
            commitTimestamp: ISODate('2024-10-05T16:10:10.123Z'),
            environment: 'infra-dev'

        },
    },
    {upsert: true}
);

db.appconfigversions.updateOne(
    {
        _id: '673728a6322164747330238d',
    },
    {
        $setOnInsert: {
            _id: '673728a6322164747330238d',
            commitSha: 'abc123',
            commitTimestamp: ISODate('2024-10-05T16:10:10.123Z'),
            environment: 'dev'

        },
    },
    {upsert: true}
);

db.appconfigversions.updateOne(
    {
        _id: '673728a6322164747330238e',
    },
    {
        $setOnInsert: {
            _id: '673728a6322164747330238e',
            commitSha: 'abc123',
            commitTimestamp: ISODate('2024-10-05T16:10:10.123Z'),
            environment: 'test'

        },
    },
    {upsert: true}
);

db.appconfigversions.updateOne(
    {
        _id: '673728a6322164747330238f',
    },
    {
        $setOnInsert: {
            _id: '673728a6322164747330238f',
            commitSha: 'abc123',
            commitTimestamp: ISODate('2024-10-05T16:10:10.123Z'),
            environment: 'perf-test'

        },
    },
    {upsert: true}
);

db.appconfigversions.updateOne(
    {
        _id: '673728a6322164747330238g',
    },
    {
        $setOnInsert: {
            _id: '673728a6322164747330238g',
            commitSha: 'abc123',
            commitTimestamp: ISODate('2024-10-05T16:10:10.123Z'),
            environment: 'ext-test'

        },
    },
    {upsert: true}
);

db.appconfigversions.updateOne(
    {
        _id: '773728a6322164747330238a',
    },
    {
        $setOnInsert: {
            _id: '773728a6322164747330238a',
            commitSha: 'abc123',
            commitTimestamp: ISODate('2024-10-05T16:10:10.123Z'),
            environment: 'prod'

        },
    },
    {upsert: true}
);
