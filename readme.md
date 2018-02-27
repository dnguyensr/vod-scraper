# vod-scraper

Video on demand scraper with basic db view.

## Deployment

### Heroku

#### Database Config

Database credentials can be retrived from Heroku under the Resources tab of the Heroku project. Click Heroku Postgres::Database under the Add-ons section and access Database Credentials in the Settings tab.

Replace host, user, and database fields with Database Credentials and run in terminal. There will be password prompt which requires the password in Heroku's Database Credentials

```
heroku run psql -h [Host] -U [User] [Database]
```

Migrations/Tables can be manually added, the example below is the same as the 001-ar.sql under the migrations dir.

```
create table vods (
  id integer primary key,
  url text not null,
  title text not null,
  date date not null
);
```
