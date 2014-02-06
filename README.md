# The Square Ruby Gem

A Ruby interface to the Square API.

## Installation

Add this line to your application's Gemfile:

    gem 'square'

And then execute:

    $ bundle install --path vendor/bundle

Or install it yourself as:

    $ gem install square

## Quick Start Guide (Square Connect API)

**Register an application with [Square Connect][square] and Get your access token.**

**Instantiate a Square::Connect::Client for each user's access**

```ruby
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
