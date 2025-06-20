-- 
-- For each patient, show their most recent activity date.

WITH activity_rank AS (
    SELECT
        patient_id,
        activity_date,
        ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY activity_date DESC) AS rank
    FROM {{ ref('fact_activities') }}
)
SELECT
    patient_id,
    activity_date AS most_recent_activity_date
FROM activity_rank
WHERE rank = 1
ORDER BY patient_id
