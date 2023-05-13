# postgres-sample-dbs

A collection of sample Postgres databases for learning, testing, and development.

# How the dataset files were created

Data was loaded into [Neon Postgres](https://neon.tech/) (Postgres 15) using the prescribed installation method, or a schema was created and the data was loaded from a delimited file (`.csv`). The data was then dumped to an `*.sql` file using the [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html) utility. For example:

```bash
pg_dump "postgres://[user]:[password]@[hostname]/[dbname]" --file=[file_name].sql --format=p --no-owner --no-privileges --no-tablespaces
```

## Loading datasets into Postgres

Data can be loaded using [psql](https://www.postgresql.org/docs/current/app-psql.html).

- [Chinook database](#chinook-database)
- [Lego database](#lego-database)
- [Netflix data](#netflix-data)
- [Pagila database](#pagila-database)
- [Periodic table data](#periodic-table-data)
- [Titanic passenger data](#titantic-passenger-data)
- [World Happiness Index](#world-happiness-index)

### Chinook database

Chinook digital media store database (11 tables, 2280 KB)

```bash
psql -d "postgres://[user]:[password]@[hostname]/chinook?sslmode=require" -f chinook.sql
```

- Source: [https://github.com/lerocha/chinook-database](https://github.com/lerocha/chinook-database)
- License: [https://github.com/lerocha/chinook-database/blob/master/LICENSE.md](https://github.com/lerocha/chinook-database/blob/master/LICENSE.md)

### Lego database

Lego database (8 tables, 35 MB)

```bash
psql -d "postgres://[user]:[password]@[hostname]/lego?sslmode=require" -f lego.sql
```
- Source: [https://www.kaggle.com/datasets/rtatman/lego-database](https://www.kaggle.com/datasets/rtatman/lego-database)
- License: [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) 

### Netflix data

Netflix shows (1 table, 3832 KB)

```bash
psql -d "postgres://[user]:[password]@[hostname]/netflix?sslmode=require" -f netflix_shows.sql
```

- Source: [https://www.kaggle.com/datasets/shivamb/netflix-shows](https://www.kaggle.com/datasets/shivamb/netflix-shows)
- License: [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) 

### Pagila database

Pagila database (22 tables, 7856 KB)

```bash
psql -d "postgres://[user]:[password]@[hostname]/pagila?sslmode=require" -f pagila.sql
```

- Source: [https://github.com/devrimgunduz/pagila](https://github.com/devrimgunduz/pagila)
- License: [LICENSE.txt](https://github.com/devrimgunduz/pagila/blob/master/LICENSE.txt)


### Periodic table data

Periodic table of elements (1 table, 72 KB)

```bash
psql -d "postgres://[user]:[password]@[hostname]/periodic_table?sslmode=require" -f periodic_table.sql
```

- Source: [https://github.com/andrejewski/periodic-table](https://github.com/andrejewski/periodic-table)
- License: [ISC License](https://github.com/andrejewski/periodic-table/blob/master/LICENSE)

### Titanic passenger data

Titanic passenger data (1 table, 408 KB)

```bash
psql -d "postgres://[user]:[password]@[hostname]/titanic?sslmode=require" -f titanic.sql
```

- Source: [https://www.kaggle.com/datasets/ibrahimelsayed182/titanic-dataset](https://www.kaggle.com/datasets/ibrahimelsayed182/titanic-dataset)
- License: [Unknown](https://www.kaggle.com/datasets/vinicius150987/titanic3))
 
### World Happiness Index

World Happiness Index (1 table, 56 KB)

```bash
psql -d "postgres://[user]:[password]@[hostname]/happiness_index?sslmode=require" -f happiness_index.sql
```

- Source: [https://www.kaggle.com/datasets/unsdsn/world-happiness](https://www.kaggle.com/datasets/unsdsn/world-happiness)
- License: [CC0: Public Domain](https://creativecommons.org/publicdomain/zero/1.0/) 



## Licensing

This repository is provided under the MIT License. However, please note that each individual database included in this repository is subject to its own license terms.

The MIT License applies to the scripts and other components that are created by me, which include the scripts that load the data into schemas and create dumps. I respect the rights of the original creators of the databases, and I only redistribute these databases in compliance with their respective licenses.

For each individual database, I have clearly indicated where the full text of the license can be found. If you choose to use any of these databases, you must comply with the terms specified in their respective licenses.
