[![CircleCI](https://circleci.com/gh/C-FO/square.svg?style=svg&circle-token=1087bf6a91644baaf16a3b2878c77e0299f691fa)](https://circleci.com/gh/C-FO/square)
[![codecov](https://codecov.io/gh/C-FO/square/branch/master/graph/badge.svg)](https://codecov.io/gh/C-FO/square)

# The Square Ruby Gem

A Ruby interface to the Square API.

## Installation

Add this line to your application's Gemfile:

    gem 'square', git: 'https://github.com/C-FO/square'

And then execute:

    $ bundle install --path vendor/bundle

## Quick Start Guide (Square Connect API)

**Register an application with [Square Connect][square] and Get your access token.**

**Instantiate a Square::Connect::Client for each user's access**

```ruby
# Load the gem
require 'square'

client = Square::Connect::Client.new(
  access_token: "Your access token"
)
```

[square]: https://connect.squareup.com/

**You can make requests as the authenticated user**

```ruby
# Fetch the list of payments
client.payments
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
