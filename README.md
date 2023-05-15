# postgres-sample-dbs

A collection of sample Postgres databases for learning, testing, and development.

# How the dataset files were created

Data was loaded into [Neon Postgres](https://neon.tech/) (Postgres 15) using the prescribed installation method, or a database schema was created and the data was loaded from a delimited file (`.csv`). The data was then dumped using the [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html) utility. For example:

```bash
pg_dump "postgres://[user]:[password]@[hostname]/[dbname]" --file=[file_name].sql --format=p --no-owner --no-privileges --no-tablespaces
```

For larger datasets, such the [employees](#employees-database) database, the following options were used: `--format=c -Z 6`

## Load a dataset into Postgres

Start by cloning the repository to your local machine or download an individual dump file.

### Clone the repository to your local machine

```bash
git clone https://github.com/danieltprice/postgres-sample-dbs.git
```

### Download an individual dump file

1. Click on the dump file to open it.
2. Above the content of the file, you should see a button labeled "Raw". Click it. This will open a new tab or window in your browser displaying the raw contents of the file.
3. Right-click anywhere in the window or tab displaying the raw file contents, and select "Save As..." or "Save Page As ..." from the context menu. Choose a location on your computer to save the file, and click "Save".

### Create a database in Postgres

You can load a dataset into any database, but the commands below assume you have a database named for the dataset. To create a database, use a `CREATE TABLE` statement:

```sql
CREATE DATABASE [dbname];
```

Alternatively, if you are using [Neon Postgres](https://neon.tech/), you can create a database from the [Neon console](https://console.neon.tech/). See [Create a database](https://neon.tech/docs/manage/databases#create-a-database) for instructions.

### Load data

The following sections describe how to load data using either the [psql](https://www.postgresql.org/docs/current/app-psql.html) client or [pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html).

- [Chinook database](#chinook-database)
- [Employees database](#employees-database)
- [Lego database](#lego-database)
- [Netflix data](#netflix-data)
- [Pagila database](#pagila-database)
- [Periodic table data](#periodic-table-data)
- [Titanic passenger data](#titantic-passenger-data)
- [World Happiness Index](#world-happiness-index)

### Chinook database

Chinook digital media store database (11 tables, 2280 KB)

Navigate to the directory where you cloned the repositpry or downloaded the dump file, and run the following command:

```bash
psql -d "postgres://[user]:[password]@[hostname]/chinook?sslmode=require" -f chinook.sql
```

- Source: [https://github.com/lerocha/chinook-database](https://github.com/lerocha/chinook-database)
- License: [https://github.com/lerocha/chinook-database/blob/master/LICENSE.md](https://github.com/lerocha/chinook-database/blob/master/LICENSE.md)

### employees database

Employees database (6 tables, 360 MB)

Create the database and schema:

```sql
CREATE DATABASE employees;
\c employees
CREATE SCHEMA employees;
```

Navigate to the directory where you cloned the repositpry or downloaded the dump file, and run the following command:

```bash
pg_restore -d postgres://[user]:[password]@[hostname]/employees -Fc -j 2 employees.sql.gz -c -v
```

- Source: The initial dataset was created by Fusheng Wang and Carlo Zaniolo from Siemens Corporate Research, and can be found in XML format at this location: [http://timecenter.cs.aau.dk/software.htm](http://timecenter.cs.aau.dk/software.htm). Designing the relational schema was undertaken by Giuseppe Maxia while Patrick Crews was responsible for transforming the data into a format compatible with MySQL. Their work can be accessed here: [https://github.com/datacharmer/test_db](https://github.com/datacharmer/test_db). Subsequently, this information was adapted to a format suitable for PostgreSQL: [ttps://github.com/h8/employees-database](https://github.com/h8/employees-database). The data was generated, and there are inconsistencies.
- License: This work is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.

### Lego database

Lego database (8 tables, 35 MB)

Navigate to the directory where you cloned the repositpry or downloaded the dump file, and run the following command:

```bash
psql -d "postgres://[user]:[password]@[hostname]/lego?sslmode=require" -f lego.sql
```
- Source: [https://www.kaggle.com/datasets/rtatman/lego-database](https://www.kaggle.com/datasets/rtatman/lego-database)
- License: [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) 

### Netflix data

Netflix shows (1 table, 3832 KB)

Navigate to the directory where you cloned the repositpry or downloaded the dump file, and run the following command:

```bash
psql -d "postgres://[user]:[password]@[hostname]/netflix?sslmode=require" -f netflix_shows.sql
```

- Source: [https://www.kaggle.com/datasets/shivamb/netflix-shows](https://www.kaggle.com/datasets/shivamb/netflix-shows)
- License: [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) 

### Pagila database

Pagila database (22 tables, 7856 KB)

Navigate to the directory where you cloned the repositpry or downloaded the dump file, and run the following command:

```bash
psql -d "postgres://[user]:[password]@[hostname]/pagila?sslmode=require" -f pagila.sql
```

- Source: [https://github.com/devrimgunduz/pagila](https://github.com/devrimgunduz/pagila)
- License: [LICENSE.txt](https://github.com/devrimgunduz/pagila/blob/master/LICENSE.txt)


### Periodic table data

Periodic table of elements (1 table, 72 KB)

Navigate to the directory where you cloned the repositpry or downloaded the dump file, and run the following command:

```bash
psql -d "postgres://[user]:[password]@[hostname]/periodic_table?sslmode=require" -f periodic_table.sql
```

- Source: [https://github.com/andrejewski/periodic-table](https://github.com/andrejewski/periodic-table)
- License: [ISC License](https://github.com/andrejewski/periodic-table/blob/master/LICENSE)

### Titanic passenger data

Titanic passenger data (1 table, 408 KB)

Navigate to the directory where you cloned the repositpry or downloaded the dump file, and run the following command:

```bash
psql -d "postgres://[user]:[password]@[hostname]/titanic?sslmode=require" -f titanic.sql
```

- Source: [https://www.kaggle.com/datasets/ibrahimelsayed182/titanic-dataset](https://www.kaggle.com/datasets/ibrahimelsayed182/titanic-dataset)
- License: [Unknown](https://www.kaggle.com/datasets/vinicius150987/titanic3)
 
### World Happiness Index

World Happiness Index (1 table, 56 KB)

Navigate to the directory where you cloned the repositpry or downloaded the dump file, and run the following command:

```bash
psql -d "postgres://[user]:[password]@[hostname]/happiness_index?sslmode=require" -f happiness_index.sql
```

- Source: [https://www.kaggle.com/datasets/unsdsn/world-happiness](https://www.kaggle.com/datasets/unsdsn/world-happiness)
- License: [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) 


## Licensing

This repository is provided under the MIT License. However, please note that each individual database included in this repository is subject to its own license terms.

The MIT License applies to the scripts and other components that are created by me, which include the scripts that load the data. I respect the rights of the original creators of the databases, and I only redistribute these databases in compliance with their respective licenses.

For each individual database, I have clearly indicated where the full text of the license can be found. If you choose to use any of these databases, you must comply with the terms specified in their respective licenses.
