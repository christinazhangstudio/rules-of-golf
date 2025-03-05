-- This is pretty niche use-case: find rows that have a duplicate values (the JSON attribute "Display Name")
-- the joins are specific to a certain use case.

WITH Duplicates AS (
    SELECT JSON_EXTRACT(o3.attributes, '$."Display Name"') AS display_name
    FROM bizobj o1
    JOIN relobj r1
        ON o1.physicalid = r1.fromObjectId
    JOIN bizobj o2
        ON r1.toObjectId = o2.physicalid
    JOIN relobj r2
        ON o2.physicalid = r2.fromObjectId
    JOIN bizobj o3
        ON r2.toObjectId = o3.physicalid
    WHERE o2.objectType = 'Variant'
        AND o3.objectType = 'Variant Value'
    GROUP BY JSON_EXTRACT(o3.attributes, '$."Display Name"')
    HAVING COUNT(*) > 1
)
SELECT o1.objectName, o1.objectType, o1.policyRef, o2.objectName, o2.attributes, o3.*
FROM bizobj o1
JOIN relobj r1
    ON o1.physicalid = r1.fromObjectId
JOIN bizobj o2
    ON r1.toObjectId = o2.physicalid
JOIN relobj r2
    ON o2.physicalid = r2.fromObjectId
JOIN bizobj o3
    ON r2.toObjectId = o3.physicalid
JOIN Duplicates d
    ON JSON_EXTRACT(o3.attributes, '$."Display Name"') = d.display_name
WHERE o2.objectType = 'Variant'
    AND o3.objectType = 'Variant Value'
LIMIT 50;
