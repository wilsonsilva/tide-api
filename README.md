# Tide::API

[![Gem Version](https://badge.fury.io/rb/tide-api.svg)](https://badge.fury.io/rb/tide-api)
[![Build Status](https://travis-ci.org/wilsonsilva/tide-api.svg?branch=master)](https://travis-ci.org/wilsonsilva/tide-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/15feb9e5e8d4faeb9921/maintainability)](https://codeclimate.com/github/wilsonsilva/tide-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/15feb9e5e8d4faeb9921/test_coverage)](https://codeclimate.com/github/wilsonsilva/tide-api/test_coverage)
[![Security](https://hakiri.io/github/wilsonsilva/tide-api/master.svg)](https://hakiri.io/github/wilsonsilva/tide-api/master)
[![Inline docs](http://inch-ci.org/github/wilsonsilva/tide-api.svg?branch=master)](http://inch-ci.org/github/wilsonsilva/tide-api)

Ruby interface to Tide's bank RESTful API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tide-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tide-api

## Usage

Tide uses `Access Tokens` to allow access to the API via OAuth 2. You can find more about authentication on 
[the official API reference](https://tideapi.github.io/docs/#authentication).

Follow the documentation until you have an `Authorization Grant Code`. I'm developing a command-line utility to
automate the authentication process.

```ruby
require 'tide/api'

client = Tide::API::Client.new

# Authentication
auth_grant_code = 'CBCAzT2L6A5oFZyE78R2TtYYtaJ60er0' 
tokens = client.fetch_tokens(auth_grant_code)

# Fetching companies
companies = client.fetch_companies

# Fetch accounts
accounts = client.fetch_accounts(companies.first.id)

# Fetch transactions 
transactions = client.fetch_transactions(accounts.first.id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies, configure git hooks and create support files.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

The health and maintainability of the codebase is ensured through a set of
Rake tasks to test, lint and audit the gem for security vulnerabilities and documentation:

```
rake bundle:audit          # Checks for vulnerable versions of gems 
rake qa                    # Test, lint and perform security and documentation audits
rake rubocop               # Lint the codebase with RuboCop
rake rubocop:auto_correct  # Auto-correct RuboCop offenses
rake spec                  # Run RSpec code examples
rake verify_measurements   # Verify that yardstick coverage is at least 100%
rake yard                  # Generate YARD Documentation
rake yard:junk             # Check the junk in your YARD Documentation
rake yardstick_measure     # Measure docs in lib/**/*.rb with yardstick
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wilsonsilva/tide-api.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected
to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tide::API project’s codebases, issue trackers, chat rooms and mailing lists
is expected to follow the [code of conduct](https://github.com/wilsonsilva/tide-api/blob/master/CODE_OF_CONDUCT.md).
