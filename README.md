[![CircleCI](https://circleci.com/gh/wilbert/kontaktliste.svg?style=svg)](https://circleci.com/gh/wilbert/kontaktliste)
[![git-flow](https://img.shields.io/badge/git-flow-green.svg)](https://github.com/nvie/gitflow)

This is the kontaktliste API, based on [Rails](http://rubyonrails.org/).

[Overview] (https://github.com/wilbert/kontaktliste/wiki/Kontaktliste)

### URLS

* http://kontaktliste.insightsistemas.com.br/docs - API documentation
* http://kontaktliste.insightsistemas.com.br - Production API environment (AWS load balanced)
* http://kontaktliste-app.insightsistemas.com.br - Production Client

## Dependencies

To run this project you need to have:

* Ruby `2.2.4` - You can use [RVM](http://rvm.io)
* Bundler `>1.3.0`
* Rails `5.0.2`

## Setup the project

1. Install the depedencies above
2. `$ git clone https://github.com/wilbert/kontaktliste.git` - Clone the project
3. `$ cd kontaktliste` - Go into the project folder
4. `$ bundle install` - Install the gem dependencies
5. `$ bundle exec rake db:create db:migrate db:schema:load RAILS_ENV=test` - Setup the database for the test environment
6. `$ bundle exec rake spec` - Run the specs to see if everything is working fine

If everything goes OK, you can now run the project!

## Running the project

1. `$ bundle exec rails server` - Opens the server
2. Open [http://localhost:3000](http://localhost:3000)

#### Running automated Tasks

`$ bundle exec rake ldap:import` to import LDAP data into app database.

#### Setup tasks in CRON

`$ bundle exec whenever --set 'environment=#{railsenv}' --update-crontab` to setup automated tasks in your crontab file based on rules available in `config/schedule.rb`.

#### Running SQS face analyzer queue consumer

`$ bundle exec shoryuken -C config/shoryuken.yml --rails` to start polling queue with ids of contacts and process faces to set gender and face center coordinates.

#### Running specs and checking coverage

`$ bundle exec rake spec` to run the specs and to generate the coverage report then open the file `coverage/index.html` on your browser.

## Working on project

Please, read this section [git-flow](https://github.com/nvie/gitflow).

## Software architecture

This application was built on top of Amazon Web Service, look into the image to see how it's distributed.

![Cloud Architecture](https://s3.amazonaws.com/kontaktliste/kontaktliste-infra.png)
[Click here to see Large](https://s3.amazonaws.com/kontaktliste/kontaktliste-infra.png)

### Deploys instructions

When you push your changes to master branch your code will be sent to production environment, when you push your code to development branch
your code will be sent to staging environment. But, the continuous delivery process
consider these artifacts:

* [Rubocop](https://github.com/bbatsov/rubocop)
* [Brakeman](https://github.com/presidentbeef/brakeman)
* [RSpec](https://github.com/rspec/rspec)

## Maintainers & Contributors

Please check https://github.com/wilbert/kontaktliste/graphs/contributors
