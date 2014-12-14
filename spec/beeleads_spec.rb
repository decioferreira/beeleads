require 'spec_helper'
require 'beeleads'

describe Beeleads::Client do
  describe 'api_url' do
    it 'has a default value' do
      client = Beeleads::Client.new()
      expect(client.instance_variable_get(:@api_url)).to eq('https://hive.bldstools.com/api.php/v1/lead/')
    end
  end

  describe '.new' do
    %w(api_url api_affiliate_id api_secret api_offer_id).each do |k|
      it 'should set the #{k} option' do
        client = Beeleads::Client.new({k.to_sym => k})
        expect(client.instance_variable_get(:"@#{k}")).to eq(k)
      end
    end

    it 'should not set the any_other option' do
      client = Beeleads::Client.new({:any_other => 'something'})
      expect(client.instance_variable_get(:@any_other)).to be_nil
    end
  end

  describe '#lead' do
    subject { Beeleads::Client.new({:api_affiliate_id => 123, :api_secret => 'secret', :api_offer_id => 7}) }
    let(:lead) { { :email => 'sample@example.net', :firstname => 'Tiago' } }

    before :each do
      allow(Beeleads::Client).to receive(:token).with('secret', lead) { 'token' }
      stub_request(:get, 'https://hive.bldstools.com/api.php/v1/lead/').with(:query => {'token' => 'token', 'affiliate_id' => 123, 'offer_id' => 7, :field => lead}).to_return(:body => {'result' => 'test'}.to_json)
      @response = subject.lead(lead)
    end

    it 'should make a get request' do
      expect(a_request(:get, 'https://hive.bldstools.com/api.php/v1/lead/').with(:query => {'token' => 'token', 'affiliate_id' => 123, 'offer_id' => 7, 'field' => lead})).to have_been_made.once
    end

    xit 'should make the request without peer verification'

    it 'should return JSON parsed body' do
      expect(@response).to eq({'result' => 'test'})
    end
  end

  describe '.token' do
    def beeleads_token(params)
      Beeleads::Client.class_eval { token('yoursecret', params) }
    end

    it 'should return the correct token' do
      expect(beeleads_token({ :email => 'sample@example.net', :firstname => 'Tiago' })).to eq('534da26a597e62b65b25711eb200197fc59ceb14')
    end

    it 'should return the same token when the params order are different' do
      expect(beeleads_token({ :email => 'sample@example.net', :firstname => 'Tiago' })).
        to eq(beeleads_token({ :firstname => 'Tiago', :email => 'sample@example.net' }))
    end
  end

  describe '.token_query' do
    def token_query(params)
      Beeleads::Client.class_eval { token_query(params) }
    end

    it 'should return the correct encoded form data' do
      expect(token_query({ :email => 'sample@example.net', :firstname => 'Tiago' })).
        to eq('email=sample%40example.net&firstname=Tiago')
    end

    it 'should convert nil to "" (empty string)' do
      expect(token_query({ :email => 'sample@example.net', :firstname => nil})).
        to eq('email=sample%40example.net&firstname=')
    end

    it 'has keys in alphabetical order' do
      expect(token_query({ :firstname => 'Tiago', :email => 'sample@example.net' })).
        to eq('email=sample%40example.net&firstname=Tiago')
    end
  end
end
