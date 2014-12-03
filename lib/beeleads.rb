require 'faraday'
require 'json'

module Beeleads
  class Client
    def initialize(options={})
      instance_variable_set(:@api_url, 'https://hive.bldstools.com/api.php/v1/lead/')
      self.class.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key]) if options[key]
      end
    end

    def lead(data)
      uri = URI(@api_url)
      conn = Faraday.new(:url => "#{uri.scheme}://#{uri.host}", :ssl => {:verify => false})
      response = conn.get uri.path, {'token' => self.class.token(@api_secret, data), 'affiliate_id' => @api_affiliate_id, 'offer_id' => @api_offer_id, 'field' => data}
      JSON.parse(response.body)
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

    def self.token(secret, data)
      Digest::SHA1.hexdigest "#{secret}#{self.token_query(data)}"
    end

    def self.token_query(data)
      URI.encode_www_form(sanitized_data(data))
    end

    def self.sanitized_data(data)
      data_without_nil = Hash[data.map{ |k, v| [k, v || ''] }]
      Hash[data_without_nil.sort_by(&:first)]
    end
  end
end
