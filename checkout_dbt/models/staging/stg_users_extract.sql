{{
  config(
    materialized = 'incremental',
    cluster_by = 'user_id',
    partition_by = {'field': 'created_at', 'data_type': 'timestamp'}
  )
}}

WITH source_tbl AS (

    SELECT

        id                     AS user_id
        , postcode,
        , created_at,
        , updated_at,
        , loader_ingestion_time

    FROM {{ checkout('users_extract') }}

{% if is_incremental() %}
    WHERE loader_ingestion_time > (SELECT MAX(loader_ingestion_time) FROM {{ this }}) -- This incremental statement will load new user data daily as the loader ingestion time should update each time the extract process runs at midnight. 
{% endif %}

)

, modified_source AS (

    SELECT 

    {{
            surrogate_key([
                'source_tbl.user_id',
                'source_tbl.updated_at'
            ])
    }}                                    AS id
    , source_tbl.user_id                  AS user_id
    , source_tbl.postcode                 AS postcode
    , source_tbl.created_at               AS created_at
    , source_tbl.updated_at               AS updated_at
    , source_tbl.loader_ingestion_time    AS loader_ingestion_time

    FROM source_tbl

)

SELECT * 
FROM modified_source
