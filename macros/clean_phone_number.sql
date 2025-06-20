{% macro clean_phone_number(json_contact_column) %}
    CASE
        WHEN NULLIF(JSON_EXTRACT_PATH_TEXT({{ json_contact_column }}, 'phone'), '-') IS NULL
            THEN NULL
        ELSE REGEXP_REPLACE(
            JSON_EXTRACT_PATH_TEXT({{ json_contact_column }}, 'phone'),
            '[^0-9+x]', '', 'g'
        )
    END
{% endmacro %}
