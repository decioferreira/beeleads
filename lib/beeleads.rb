require 'faraday'

module Beeleads
  class Client
    def initialize(options={})
      instance_variable_set(:@api_url, 'https://hive.bldtools.com/api.php/v1/lead/')
      self.class.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key]) if options[key]
      end
    end

    def lead(data)
      uri = URI(@api_url)
      conn = Faraday.new(:url => "#{uri.scheme}://#{uri.host}")
      conn.get uri.path, {'token' => self.class.token(data), 'affiliate_id' => @api_affiliate_id, 'offer_id' => @api_offer_id}
    end

  private
    def self.keys
      @keys ||= [
        :api_url,
        :api_affiliate_id,
        :api_secret,
        :api_offer_id
      ]
    end
  end
end
