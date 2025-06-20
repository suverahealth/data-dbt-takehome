SELECT *
FROM {{ ref('dim_patients') }}
WHERE registration_date > current_date
