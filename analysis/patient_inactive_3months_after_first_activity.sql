-- 
-- Find Patients who had no activity for 3 months after their first activity.

with patient_activities AS (
    SELECT
        patient_id,
        activity_date,
        ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY activity_date) AS rn,
        MIN(activity_date) OVER (PARTITION BY patient_id) AS first_activity_date
    FROM {{ ref('fact_activities') }} AS activities
),
activities_after_first AS (
    SELECT
        patient_id,
        activity_date,
        first_activity_date
    FROM patient_activities
    WHERE activity_date > first_activity_date
      AND activity_date <= first_activity_date + INTERVAL 3 MONTH
),
patients_with_no_activity_in_3months AS (
    SELECT DISTINCT
        p.patient_id,
        p.first_activity_date,
    FROM patient_activities p
    LEFT JOIN activities_after_first a
        ON p.patient_id = a.patient_id
    WHERE p.rn = 1
      AND a.patient_id IS NULL
)
SELECT
    patient_id,
    first_activity_date
FROM patients_with_no_activity_in_3months
ORDER BY patient_id, first_activity_date
