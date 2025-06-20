SELECT
    pcn_id,
    pcn_name
FROM {{ ref('stg_pcns') }}
