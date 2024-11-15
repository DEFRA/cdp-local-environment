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