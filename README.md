# WaxPoeticRecords.com

The official site of my open-source record label and publisher,
**Wax Poetic Music**. Currently, this site just displays our catalog of
releases and artists roster, but soon it will be the central online
store for purchasing "open-source" licensed editions of Wax Poetic
releases. It was primarily built with [Ruby on Rails](http://rubyonrails.org)
and [Ember.js](http://emberjs.com), with a major "tip of the hat" to
[Zurb Foundation](http://foundation.zurb.com) for its capability to
"rapid prototype" CSS and JS interaction.

## Features

- Artist and release catalog
- Online store using [Stripe](http://stripe.com) for payment processing

### Roadmap

- Add integration tests with Capybara
- Add javascript tests with Jasmine (run with Teaspoon)
- Integrate responsive image features of Foundation

## Development

Did you find a bug, or do you just want to see how it all "ticks"? The
app that powers <http://waxpoeticrecords.com> is just a Rails/Ember app,
and is built pretty conventionally. Set it up as normal, make your fix
and send me a pull request!

The only caveat you have to worry about is the `.env` file. I use
AutoEnv locally and Heroku in production, so keeping configuration in
a hidden file is not too difficult for me, and ensures that I keep
credentials out of the repo. You should copy the `.env.example` file to
`.env` and then `source .env` before running the server.

We use [Foreman](http://ddollar.github.io/foreman/) to run the app, both
locally and in production (Heroku). Run `bundle exec foreman start` to
get the app up and running. Don't forget to run `bundle exec rake db` to
get the DB set up first!

### Setup

Make sure you have [PostgreSQL](http://postgresql.org),
[Bundler](http://gembundler.com) and [Ruby 1.9.3](http://ruby-lang.org)
before continuing!

Install the bundle:

    $ bundle install

Set up the database:

    $ rake db

Run tests if you need to:

    $ rake test

Start the server:

    $ rails server
