WITH raw_data AS (
    SELECT
        data::json AS patient_info
    FROM {{ ref('raw_patients') }}
),
cleaned_data AS (
    SELECT
        CAST(patient_info->>'patient_id' AS INT) AS patient_id,
        CAST(patient_info->>'practice_id' AS INT) AS practice_id,
        CAST(patient_info->>'age' AS INT) AS age,
        patient_info->>'gender' AS gender,
        patient_info->>'registration_date' AS registration_date,
        patient_info->'conditions' AS conditions,
        patient_info->'contact' AS contact,
        ROW_NUMBER() OVER (
            PARTITION BY patient_info->>'patient_id' ORDER BY patient_info->>'registration_date' DESC
        ) AS rn
    FROM raw_data
    WHERE patient_info->>'patient_id' IS NOT NULL
        AND TRY_CAST(patient_info->>'practice_id' AS INT) IS NOT NULL
        AND TRY_CAST(patient_info->>'patient_id' AS INT) IS NOT NULL
)
SELECT
    cleaned_data.patient_id,
    cleaned_data.practice_id,
    CASE
        WHEN cleaned_data.age BETWEEN 0 AND 120
            THEN cleaned_data.age
        ELSE NULL
    END AS age,
    CASE
        WHEN cleaned_data.age BETWEEN 0 AND 18 THEN '0-18'
        WHEN cleaned_data.age BETWEEN 19 AND 35 THEN '19-35'
        WHEN cleaned_data.age BETWEEN 36 AND 50 THEN '36-50'
        WHEN cleaned_data.age >= 51 THEN '51+'
        ELSE NULL
    END AS age_group,
    CASE
        -- # Assumption: only 'F' and 'M' are found in the dataset
        WHEN cleaned_data.gender IN ('M', 'F') THEN cleaned_data.gender
        ELSE NULL
    END AS gender,
    cleaned_data.registration_date::DATE AS registration_date,
    cleaned_data.conditions,
    {{ clean_phone_number('contact') }} AS phone_number,
    JSON_EXTRACT_PATH_TEXT(cleaned_data.contact, 'email') AS email
FROM cleaned_data
WHERE cleaned_data.rn = 1
