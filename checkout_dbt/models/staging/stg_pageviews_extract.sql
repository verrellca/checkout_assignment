{{
  config(
    materialized = 'incremental',
    cluster_by = 'user_id',
    partition_by = {'field': 'event_time', 'data_type': 'timestamp'}
  )
}}

WITH source_tbl AS (

    SELECT

        user_id                   AS pageviews_user_id 
        , url                     AS web_page
        , event_id
        , event_time
        , loader_ingestion_time

    FROM {{ checkout('pageviews_extract') }}

{% if is_incremental() %}
    WHERE loader_ingestion_time > (SELECT MAX(loader_ingestion_time) FROM {{ this }})
{% endif %}

)

SELECT * 
FROM source_tbl
