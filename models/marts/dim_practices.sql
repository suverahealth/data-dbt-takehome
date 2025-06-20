SELECT
    practices.pcn_id,
    practices.practice_id,
    practices.practice_name,
    practices.location,
    practices.established_date
FROM {{ ref('stg_practices') }} AS practices
INNER JOIN {{ ref('dim_pcns') }} AS pcns
    ON pcns.pcn_id = practices.pcn_id
