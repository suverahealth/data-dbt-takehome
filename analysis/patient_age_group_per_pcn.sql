-- 
-- Categorize patients into age groups (0-18, 19-35, 36-50, 51+) and show the count per group per PCN.

SELECT
    pcns.pcn_name,
    patients.age_group,
    COUNT(patients.patient_id) AS total_patients,
FROM {{ ref('dim_patients') }} AS patients
INNER JOIN {{ ref('dim_practices') }} AS practices
    ON patients.practice_id = practices.practice_id
INNER JOIN {{ ref('dim_pcns') }} AS pcns  
    ON practices.pcn_id = pcns.pcn_id
WHERE patients.age_group != ''
GROUP BY pcns.pcn_name, patients.age_group
ORDER BY pcns.pcn_name, patients.age_group
