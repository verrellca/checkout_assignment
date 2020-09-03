CREATE SCHEMA checkout_sources;

CREATE TABLE users_extract (
	id INT ( 8 ) PRIMARY KEY,
	postcode VARCHAR ( 50 ) NOT NULL,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
        loader_ingestion_time TIMESTAMP  NOT NULL
);

CREATE TABLE pageviews_extract (
	user_id INT ( 8 ) NOT NULL,
	url VARCHAR ( 50 ) NOT NULL,
	event_id VARCHAR ( 50 ) PRIMARY KEY NOT NULL UNIQUE,
	created_at TIMESTAMP NOT NULL,
        loader_ingestion_time TIMESTAMP  NOT NULL
); 
