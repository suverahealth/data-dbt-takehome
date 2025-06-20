SELECT
    practices.id AS practice_id,
    practices.practice_name,
    practices.location,
    practices.established_date,
    practices.pcn AS pcn_id
FROM {{ ref('raw_practices') }} AS practices
