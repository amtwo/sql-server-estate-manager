DELETE pl
FROM Staging.SqlPatchLevels AS pl
WHERE MajorVersion = 11;

INSERT INTO Staging.SqlPatchLevels (ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate)
SELECT ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate
FROM (VALUES
    ('11.0.2100.60', 11.00, 'RTM', NULL,   '20120401', '20140114'),
    ('11.0.3128.0',  11.00, 'SP1', NULL,   '20130731', '20150714'),
    ('11.0.3431',    11.00, 'SP1', 'CU11', '20140721', '20150714'),
    ('11.0.3470',    11.00, 'SP1', 'CU12', '20140915', '20150714'),
    ('11.0.3482',    11.00, 'SP1', 'CU13', '20141117', '20150714'),
    ('11.0.3486',    11.00, 'SP1', 'CU14', '20150119', '20150714'),
    ('11.0.3487',    11.00, 'SP1', 'CU15', '20150316', '20150714'),
    ('11.0.3492',    11.00, 'SP1', 'CU16', '20150518', '20150714'),
    ('11.0.5058',    11.00, 'SP2', NULL,   '20140610', '20170110'),
    ('11.0.5532',    11.00, 'SP2', 'CU1',  '20140723', '20170110'),
    ('11.0.5548',    11.00, 'SP2', 'CU2',  '20140915', '20170110'),
    ('11.0.5556',    11.00, 'SP2', 'CU3',  '20141117', '20170110'),
    ('11.0.5569',    11.00, 'SP2', 'CU4',  '20150119', '20170110'),
    ('11.0.5582',    11.00, 'SP2', 'CU5',  '20150316', '20170110'),
    ('11.0.5592',    11.00, 'SP2', 'CU6',  '20150518', '20170110'),
    ('11.0.5613',    11.00, 'SP2', 'QFE',  '20150714', '20170110'),
    ('11.0.5623.0',  11.00, 'SP2', 'CU7',  '20150720', '20170110'),
    ('11.0.5634.0',  11.00, 'SP2', 'CU8',  '20150720', '20170110'),
    ('11.0.5641.0',  11.00, 'SP2', 'CU9',  '20151118', '20170110'),
    ('11.0.5644.2',  11.00, 'SP2', 'CU10', '20160120', '20170110'),
    ('11.0.5646.2',  11.00, 'SP2', 'CU11', '20160321', '20170110'),
    ('11.0.5649.0',  11.00, 'SP2', 'CU12', '20160516', '20170110'),
    ('11.0.5655',    11.00, 'SP2', 'CU13', '20160718', '20170110'),
    ('11.0.5657',    11.00, 'SP2', 'CU14', '20160921', '20170110'),
    ('11.0.5676.0',  11.00, 'SP2', 'CU15', '20161117', '20170110'),
    ('11.0.5678.0',  11.00, 'SP2', 'CU16', '20170118', '20170110'),
    ('11.0.6020.0',  11.00, 'SP3', NULL,   '20151121', '20181009'),
    ('11.0.6518.0',  11.00, 'SP3', 'CU1',  '20160120', '20181009'),
    ('11.0.6523.0',  11.00, 'SP3', 'CU2',  '20160321', '20181009'),
    ('11.0.6537.0',  11.00, 'SP3', 'CU3',  '20160517', '20181009'),
    ('11.0.6540.0',  11.00, 'SP3', 'CU4',  '20160718', '20181009'),
    ('11.0.6544.0',  11.00, 'SP3', 'CU5',  '20160921', '20181009'),
    ('11.0.6567.0',  11.00, 'SP3', 'CU6',  '20161117', '20181009'),
    ('11.0.6579.0',  11.00, 'SP3', 'CU7',  '20170118', '20181009'),
    ('11.0.6594.0',  11.00, 'SP3', 'CU8',  '20170401', '20181009'),
    ('11.0.6598.0',  11.00, 'SP3', 'CU9',  '20170515', '20181009'),
    ('11.0.6607.3',  11.00, 'SP3', 'CU10', '20170808', '20181009'),
    ('11.0.7001.0',  11.00, 'SP4', NULL,   '20171005', '20220712'),
    ('11.0.7469.6',  11.00, 'SP4', 'GDR',  '20180115', '20220712'),
    ('11.0.7493.4',  11.00, 'SP4', 'GDR',  '20200211', '20220712'),
    ('11.0.7507.2',  11.00, 'SP4', 'GDR',  '20210114', '20220712'),
    ('11.00.3000',   11.00, 'SP1', NULL,   '20121107', '20150714')
) AS x(ProductVersion, MajorVersion, ProductLevel, ProductUpdateLevel, ReleaseDate, SupportEndDate);

EXEC SqlServer.PatchLevels_Load @MajorVersion = 11;