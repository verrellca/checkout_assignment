-- The followiong query answers: 
-- Number of pageviews, on a given time period (hour, day, month, etc), per postcode -
-- based on the postcode a user was in at the time when that user made a pageview.

SELECT DATE_TRUNC('day', event_time) AS day, -- UPDATE time period here for hour / month etc.
	   user_daily_postcode,
	   COUNT(event_id) 
FROM user_pageviews
GROUP BY day, user_daily_postcode
ORDER BY day