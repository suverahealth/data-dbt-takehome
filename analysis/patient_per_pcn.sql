-- 
-- How many patients belong to each PCN?

SELECT
    pcns.pcn_name,
    COUNT(DISTINCT patients.patient_id) AS total_patients,
FROM {{ ref('dim_patients') }} AS patients
INNER JOIN {{ ref('dim_practices') }} AS practices
    ON patients.practice_id = practices.practice_id
INNER JOIN {{ ref('dim_pcns') }} AS pcns  
    ON practices.pcn_id = pcns.pcn_id
GROUP BY pcns.pcn_name
