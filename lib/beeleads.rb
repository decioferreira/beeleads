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
      Faraday.get @api_url
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
