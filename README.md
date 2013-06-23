# Beeleads

[![Build Status](https://travis-ci.org/decioferreira/beeleads.png?branch=master)](https://travis-ci.org/decioferreira/beeleads)

A Ruby interface to the Beeleads API.

## Installation

Add this line to your application's Gemfile:

    gem 'beeleads'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install beeleads

## Usage

In order to use Beeleads' Lead Integration API (version 1.0) make sure you have the following information:

* Affiliate ID
* API Secret
* Offer ID

If you are missing any of this info, please contact suporte@beeleads.com.br.

```ruby
require 'beeleads'
client = Beeleads::Client.new({:api_affiliate_id => ENV['API_AFFILIATE_ID'], :api_secret => ENV['API_SECRET'], :api_offer_id => ENV['API_OFFER_ID']})
response = client.lead({'email' => 'sample@example.net', 'firstname' => 'Tiago'})
```

The result has the following structure:

```ruby
{
  "request" => {
    "time" => "2013-03-29 10:10:00",
    "data" => {
      "token" => "0d91dc50fc537bf975d91468efd381a1d8c250e1",
      "affiliate_id" => "1234",
      "offer_id" => "0",
      "field" => {
        "email" => "sample@example.net",
        "firstname" => "Tiago"
      }
    }
  },
  "response" => {
    "status" => 200,
    "message" => "OK"
    "data" => {
      "lead_id" => "573a872f9f68149b867dde997f5160f00f79cff3",
      "status"=>"PENDING_APPROVAL"
    }
  }
}
```

The response status codes can be:

* 200 - OK
* 400 - Invalid Request Data
* 401 - Invalid Token
* 500 - Internal Error

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
