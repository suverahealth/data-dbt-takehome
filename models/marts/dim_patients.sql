SELECT
    patients.patient_id,
    patients.practice_id,
    patients.age,
    patients.age_group,
    patients.gender,
    patients.registration_date,
    patients.conditions,
    patients.phone_number,
    patients.email
FROM {{ ref('stg_patients') }} AS patients
INNER JOIN {{ ref('dim_practices') }} AS practices
    ON patients.practice_id = practices.practice_id
