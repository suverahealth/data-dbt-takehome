SELECT
    id AS pcn_id,
    pcn_name
FROM {{ ref('raw_pcns')}}
