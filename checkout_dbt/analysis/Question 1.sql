-- The followiong query answers: 
-- Number of pageviews, on a given time period (hour, day, month, etc), per postcode -
-- based on the current/most recent postcode of a user.

SELECT DATE_TRUNC('day', event_time) AS day, -- UPDATE time period here for hour / month etc.
	   user_current_postcode,
	   COUNT(event_id) 
FROM user_pageviews
GROUP BY day, user_current_postcode
ORDER BY day