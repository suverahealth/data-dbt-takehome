SELECT *
FROM {{ ref('dim_patients') }}
WHERE age < 0 OR age > 120
