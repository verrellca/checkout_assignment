{{
  config(
    materialized = 'incremental',
    cluster_by = 'event_id',
    partition_by = {'field': 'event_time', 'data_type': 'timestamp'}
  )
}}

WITH user_current AS (

	SELECT

         user_id
        , postcode
        , ROW_NUMBER() OVER (PARTITION_BY loader_ingestion_time DESC) AS row_num


        FROM {{ ref('stg_users_extract') }}           AS stg_users_extract

),

	user_daily AS (

	SELECT

        user_id,
        , postcode
        , loader_ingestion_time

        FROM {{ ref('stg_users_extract') }}           AS stg_users_extract

	),

	pageviews AS (

	SELECT

	pageviews_user_id 
        , web_page
        , event_id
        , event_time
        , loader_ingestion_time

	FROM {{ ref('stg_pageviews_extract') }}
		
{% if is_incremental() %}
    WHERE loader_ingestion_time > (SELECT MAX(loader_ingestion_time) FROM {{ this }})
{% endif %}

	)

SELECT pageviews_user_id
       , web_page
       , event_id
       , event_time,
       , user_daily.postcode AS user_daily_postcode
       , user_current.postcode AS user_current_postcode 
FROM pageviews
INNER JOIN user_daily ON pageviews.pageviews_user_id = user_daily.user_id 
					 AND DATE_TRUNC('day', pageviews.event_time) = DATE_TRUNC('day', user_daily.loader_ingestion_time)
INNER JOIN user_current ON pageviews.pageviews_user_id = user_current.user_id AND user_current.row_num = 1 

