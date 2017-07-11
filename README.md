### Overview

[![Build status](https://api.travis-ci.org/applift/hasoffersv3.png?branch=master)](http://travis-ci.org/applift/hasoffersv3)
[![Gem Version](https://badge.fury.io/rb/hasoffersv3.svg)](https://badge.fury.io/rb/hasoffersv3)

### Synopsis

This gem provides a wrapper around HasOffers API in version 3, [HasOffers APIv3 Documentation](http://developers.hasoffers.com/#/brand).

### Compatibility

Supported ruby versions:

*   2.2
*   2.3
*   2.4

## Installation

    gem install hasoffersv3

## Usage

First, check if the method you want to call is already defined in `hasoffersv3/lib/hasoffersv3/*`. If not, you will need to add the method yourself (either just use your fork or submit a PR with your changes).

Next, create an initializer in your project in `config/intializers`:

```ruby
HasOffersV3.configure do |config|
  config.api_key      = 'Your HasOffers API Key'
  config.network_id   = 'Your HasOffers Network ID'
  config.read_timeout = 10
  config.raise_errors = true # add this if you want the hasoffersv3 to raise errors upon detected API error messages in responses; defaults to `false`

  # Optionally configure a proxy:
  config.proxy_host   = 'yourproxy.com'
  config.proxy_port   = 8080
end
```

You can now use the defined methods, following this pattern:


```ruby
HasOffersV3::ControllerName.snake_case_method_name
```

If HasOffers method does not take any parameters, then API also doesn't take them, otherwise it should be always a hash.

Naming is the same as in HasOffers documentation, also if it requires attributes then API will raise an exception if it's missing.

Examples:

```ruby
HasOffersV3::Affiliate.update_payment_method_wire({ affiliate_id: '877', data: {} })
```

  or when working with forms:

```ruby
HasOffersV3::Advertiser.signup({
  account: {
    company: params[:company_name],
    country: params[:company_country],
    address1: 'Change me 123',
    zipcode: '123123'
  },
  user: {
    first_name: params[:user_name],
    email: params[:user_email],
    password: params[:user_password],
    password_confirmation: params[:user_password_confirmation]
  },
  return_object: 1
})
```

### Error handling

If `config.raise_errors` was set to `true`, the `hasoffersv3` will raise internal exceptions when error occurs at protocol or business logic level. See the [`HasOffersV3::Error`](https://github.com/applift/hasoffersv3/blob/master/lib/hasoffersv3/error.rb) and its descendants' definitions for more comments and details.

### Logging

To enable log you can set a logger in configuration. All HTTP requests and responses will be logged.

To disable it, just set the logger configuration to `nil` value. Default is disabled.

An example setting Rails logger:

```ruby
HasOffersV3.configure do |config|
  config.logger = Rails.logger
end
```

## Testing

If `RAILS_ENV` or `RACK_ENV` is set to `test`, or there's a `TEST`
environment variable, it will require the HasOffersV3::Testing module
and enable testing mode. In testing mode all requests will return
stubbed successful response with empty data set.

When you need to disable testing mode:

```ruby
HasOffersV3::Testing.disable!
```

When you want to provide custom stub:

```ruby
HasOffersV3::Testing.stub_request status_code, body
```
