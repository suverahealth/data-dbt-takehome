-- 
-- What percentage of patients have Hypertension at each practice?

WITH patient_counts AS (
    SELECT
        practices.practice_id,
        practices.practice_name,
        COUNT(patients.patient_id) AS total_patients,
        COUNT(
            CASE 
                WHEN patients.conditions LIKE '%hypertension%' 
                THEN patients.patient_id 
            END
        ) AS hypertension_patients
    FROM {{ ref('dim_patients' )}} AS patients
    INNER JOIN {{ ref('dim_practices') }} AS practices
        ON patients.practice_id = practices.practice_id
    GROUP BY practices.practice_id, practices.practice_name
)
SELECT
    practice_name,
    CAST(
        CASE 
            WHEN total_patients > 0 
            THEN (hypertension_patients::FLOAT / total_patients) * 100 
            ELSE 0 
        END
    AS DECIMAL(10, 2)) AS hypertension_percentage
FROM patient_counts
ORDER BY practice_name
