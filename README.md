# Beeleads

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
client.lead({'email' => 'sample@example.net', 'firstname' => 'Tiago'})
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
