# Tide::API

[![Gem Version](https://badge.fury.io/rb/tide-api.svg)](https://badge.fury.io/rb/tide-api)
[![Build Status](https://travis-ci.org/wilsonsilva/tide-api.svg?branch=master)](https://travis-ci.org/wilsonsilva/tide-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/15feb9e5e8d4faeb9921/maintainability)](https://codeclimate.com/github/wilsonsilva/tide-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/15feb9e5e8d4faeb9921/test_coverage)](https://codeclimate.com/github/wilsonsilva/tide-api/test_coverage)
[![Security](https://hakiri.io/github/wilsonsilva/tide-api/master.svg)](https://hakiri.io/github/wilsonsilva/tide-api/master)
[![Inline docs](http://inch-ci.org/github/wilsonsilva/tide-api.svg?branch=master)](http://inch-ci.org/github/wilsonsilva/tide-api)

Ruby interface to Tide's bank RESTful API.

## Table of contents
- [Installation](#installation)
- [Usage](#usage)
  - [Authentication](#authentication)
  - [Obtaining an Authorization Grant Code](#obtaining-an-azuthorization-grant-code)
  - [Exchanging an Authorisation Grant for an Access Token](#exchanging-an-authorisation-grant-for-an-access-token)
  - [Fetching Companies](#fetching-companies)
  - [Fetching Accounts](#fetching-accounts)
  - [Fetching Transactions](#fetching-transactions)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

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

### Authentication

Tide uses `Access Tokens` to allow access to the API via OAuth 2. Tide uses `Access Token`s to allow access to the
API via OAuth 2. You can obtain an OAuth 2 `Access Toke`n by navigating to the below url, either in the web application
or through an in-app browser window:

`https://api.tide.co/tide-backend/oauth/index.html?redirect_url={url}&client_id={unique_id}`

| Parameter | Type | Description |
| --- | --- | --- |
| `redirect_uri` | string | Fully qualified URL to which `Authorisation Grants` will be delivered to. Grants will be delivered only on successful authorisation by resource owner. |
| `client_id` | string | Unique identifier for the requester. |

Once the page loads, the user needs to enter the unique email address, which is registered on their Tide account.

### Obtaining an Authorization Grant Code
Use the bundled minimalistic AuthServer to automate the process above:

```ruby
require 'tide/api'
require 'tide/api/auth_server'

server = Tide::API::AuthServer.new
auth_grant_code = server.run
```

`Authorisation Grants` can only be used once off by the client, once used they are expired and cannot be used to issue
new `Access Tokens`.

### Exchanging an Authorisation Grant for an Access Token
Exchange the authorisation grant code with the method `fetch_tokens`:

```ruby
client = Tide::API::Client.new
tokens = client.fetch_tokens(auth_grant_code)

# Tokens contains an access token and a refresh token
tokens.access_token
tokens.refresh_token
````

Fetch tokens will configure the client the behind the scenes to make authenticated requests.

### Fetching Companies
This method retrieves a collection of companies with the user. The user is determined from authorization header.

```ruby
client = Tide::API::Client.new
companies = client.fetch_companies
````

### Fetching Accounts
This method retrieves a collection of company accounts associated with the user. The user is determined from
authorization header.

```ruby
accounts = client.fetch_accounts(companies.first.id)
````

### Fetching Transactions
This method retrieves a collection of an account's transactions:

```ruby
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
