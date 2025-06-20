-- 
-- Uncomment the following config block to enable incremental loading.
{#
    {{ config(
        materialized='incremental',
        unique_key='activity_id',
        incremental_strategy='delete+insert',
        enabled=true
    ) }}
#}

SELECT
    activities.activity_id,
    activities.patient_id,
    activities.activity_type,
    activities.activity_date,
    activities.duration_minutes
FROM {{ ref('stg_activities') }} AS activities
INNER JOIN {{ ref('dim_patients') }} AS patients
    ON activities.patient_id = patients.patient_id

--
-- The following is the incremental model example to capture new or updated activities.
-- This model does not include the logic for updating records if there are changes but the activity_date is less than the max date in the target table.
-- To handle that, the stg_activities model should be updated to include a row_hash or similar mechanism to track changes using which the fact_activities can be updated.
{#
    {% if is_incremental() %}
    WHERE activities.activity_date >= (SELECT MAX(activities.activity_date) FROM {{ this }})
    {% endif %}
#}
