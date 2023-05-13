# postgres-sample-dbs

A collection of sample Postgres databases for learning, testing, and development.

# How the dataset files were created

Data was loaded into [Neon Postgres](https://neon.tech/) (Postgres 15) using the prescribed installation method, or a schema was created for the raw data and data was loaded from a delimited file (.csv). Next, the data was dumped to `*.sql` files using the [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html) utility. For example:

```bash
pg_dump "postgres://[user]:[password]@[hostname]/[dbname]" --file=[file_name].sql --format=p --no-owner --no-privileges --no-tablespaces
```

## Loading datasets into Postgres

Data can be loaded using [psql](https://www.postgresql.org/docs/current/app-psql.html) using the following commands:

### Periodic table data

psql -d "postgres://daniel:<password>@ep-mute-rain-952417.us-east-2.aws.neon.tech/periodic_table?sslmode=require" -f periodic_table.sql

### Titanic data

psql -d "postgres://daniel:<password>@ep-mute-rain-952417.us-east-2.aws.neon.tech/titanic?sslmode=require" -f titanic.sql

### Netfllix data
  
psql -d "postgres://daniel:<password>@ep-mute-rain-952417.us-east-2.aws.neon.tech/netflix?sslmode=require" -f netflix_shows.sql
  
### Lego data

psql -d "postgres://daniel:<password>@ep-mute-rain-952417.us-east-2.aws.neon.tech/lego?sslmode=require" -f lego.sql
  
### Happines index

psql -d "postgres://daniel:<password>@ep-mute-rain-952417.us-east-2.aws.neon.tech/happiness_index?sslmode=require" -f happiness_index.sql
  
### Chinook dataset

psql -d "postgres://daniel:<password>@ep-mute-rain-952417.us-east-2.aws.neon.tech/chinook?sslmode=require" -f chinook.sql
  
### Pagila dataset

psql -d "postgres://daniel:<password>@ep-mute-rain-952417.us-east-2.aws.neon.tech/chinook?sslmode=require" -f pagila.sql

## Licensing

This repository is provided under the MIT License. However, please note that each individual database included in this repository is subject to its own license terms.

The MIT License applies to the scripts and other components that are created by me, which include the scripts that load the data into schemas and create dumps. I respect the rights of the original creators of the databases, and I only redistribute these databases in compliance with their respective licenses.

For each individual database, I have provided the respective licenses along with the database files, or I have clearly indicated where the full text of the license can be found. If you choose to use any of these databases, you must comply with the terms specified in their respective licenses.
