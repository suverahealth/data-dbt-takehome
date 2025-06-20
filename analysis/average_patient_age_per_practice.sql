-- 
-- What's the average patient age per practice?

SELECT
    practices.practice_name,
    ROUND(AVG(patients.age)) AS average_patient_age -- removing rounding gives the exact average if needed
FROM {{ ref('dim_patients') }} AS patients
INNER JOIN {{ ref('dim_practices') }} AS practices
    ON patients.practice_id = practices.practice_id
GROUP BY practices.practice_name
