# README

## Techstack
- Ruby on Rails: A framework of Ruby.
- Tailwindcss: Weploy use Tailwindcss so I try it in this app. 
- Heroku: I'm familiar with Heroku. If I had more time, I would try AWS.
- PostgreSQL: I'm familiar with it. Easy to deploy as well.

## Install

### Clone the repository

```shell
git clone git@github.com:tientaidev/Timesheets.git
cd TimeSheets
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle
npm install
```

### Initialize the database

```shell
rails db:create db:migrate
```

### Test

````shell
rails test
````

## Serve

To run server locally

```shell
rails s
```

You can also access deployed version at:
(https://tientai-timesheets.herokuapp.com/)