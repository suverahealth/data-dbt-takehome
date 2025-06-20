with remove_duplicate as (
    SELECT
        activity_id,
        patient_id,
        activity_type,
        activity_date,
        duration_minutes,
        ROW_NUMBER() OVER (
            PARTITION BY activity_id
            ORDER BY activity_date DESC, patient_id
        ) AS rn
    FROM {{ ref('raw_activities') }} AS activities
    WHERE patient_id IS NOT NULL
)
SELECT
    activity_id,
    patient_id,
    activity_type,
    activity_date,
    ABS(duration_minutes) AS duration_minutes
FROM remove_duplicate
WHERE rn = 1
