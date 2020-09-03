# checkout

Here contains the repository answering the questions to the assignment provided

The checkout_data.sql file contains the code used to create / design the schemas and tables within the database.

The checkout_dbt folder contains the files required to run a dbt project based on the tables created in the checkout_data.sql file. 

This includes:
 - The staging layer where the raw data is taken and tested/cleaned for it's integrity.
 - The mart layer where the data is transformed as per the business requirements. This holds the user_pageviews.sql file which should be considered the final table. This should allow the BI tool answer the two business questions.

The checkout_dbt folder also contains an analysis folder which holds the SQL queries to answer the 2 business questions in the assignment. 

### Mechanism for scheduling transform pipeline.

For running the dbt project I propose to do this via the DBT cloud interface which means we are able to:

- Run jobs on a schedule
- View logs for any historical invocation of dbt
- Configure error notifications

### How to run the DBT project 

In the DBT Cloud IDE we can see all the folders in our project.

To schedule your the dbt project:
- Select “Jobs” from the side menu.
- Click on “New Job".
- Give your new “Job” a name, select the “Environment” you want to automate.
- Next, you can tell the “Job” which dbt commands to run, ‘dbt run’ is used by default - you can also add  'dbt test' to ensure your data quality tests have passed. 
- Finally, you can tell the “Job” when you want it to run.
- This will kick off the automated running of dbt.

