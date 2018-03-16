# vod-scraper

Video on demand scraper with public and admin view.

## Development

### Database

#### Create database

Create database by running the code below with your choice of database name.

```bash
createdb [database name]
```

### Environment Variables


| ENV Variable  | Value         |
| ------------- |:-------------:|
| DATABASE_URL  | postgres://username:password@localhost:5432/database_name|
| ADMIN_PASS    | value used in basic authentication for admin access      |

For DATABASE_URL, use local postgres cresdentials for username and passsowrd. Database_name should be the one used in creating the database. Port 5432 is the default Postgres port which should be updated if Postgres is set to a non-default port value.

### Migrations

To run migrations, run the code below with correct migration file and database name:

```bash
cat migrations/filename.sql | psql database_name
```

Command line should return `CREATE TABLE`.

Table creation can be optionally verified by entering the database with command

```bash
psql database_name
```

and querying the table

```psql
select * from table_name;
```

## Deployment

### Heroku

#### Config Variarables

| ENV Variable  | Value         |
| ------------- |:-------------:|
| ADMIN_PASS    | value used in basic authentication for admin access      |


#### Database Config

Database credentials can be retrived from Heroku under the Resources tab of the Heroku project. Click Heroku Postgres::Database under the Add-ons section and access Database Credentials in the Settings tab.

Replace host, user, and database fields with Database Credentials and run in terminal. There will be password prompt which requires the password in Heroku's Database Credentials

```bash
heroku pg:psql
```

Migrations/Tables can be manually added, the example below is the same as the 001-ar.sql under the migrations dir.

```sql
create table vods (
  id integer primary key,
  url text not null,
  title text not null,
  date date not null
);
```

#### Rake Tasks

[Heroku Scheduler](https://elements.heroku.com/addons/scheduler) can be added to the project to run rake tasks
