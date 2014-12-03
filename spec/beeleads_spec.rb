require 'spec_helper'
require 'beeleads'

describe Beeleads::Client do
  describe 'api_url' do
    it 'has a default value' do
      client = Beeleads::Client.new()
      client.instance_variable_get(:@api_url).should eq('https://hive.bldstools.com/api.php/v1/lead/')
    end
  end

  describe '.new' do
    %w(api_url api_affiliate_id api_secret api_offer_id).each do |k|
      it 'should set the #{k} option' do
        client = Beeleads::Client.new({k.to_sym => k})
        client.instance_variable_get(:"@#{k}").should eq(k)
      end
    end

    it 'should not set the any_other option' do
      client = Beeleads::Client.new({:any_other => 'something'})
      client.instance_variable_get(:@any_other).should be_nil
    end
  end

  describe '#lead' do
    subject { Beeleads::Client.new({:api_affiliate_id => 123, :api_secret => 'secret', :api_offer_id => 7}) }
    let(:lead) { { :email => 'sample@example.net', :firstname => 'Tiago' } }

    before :each do
      Beeleads::Client.stub(:token).with('secret', lead) { 'token' }
      stub_request(:get, 'https://hive.bldstools.com/api.php/v1/lead/').with(:query => {'token' => 'token', 'affiliate_id' => 123, 'offer_id' => 7, :field => lead}).to_return(:body => {'result' => 'test'}.to_json)
      @response = subject.lead(lead)
    end

    it 'should make a get request' do
      a_request(:get, 'https://hive.bldstools.com/api.php/v1/lead/').with(:query => {'token' => 'token', 'affiliate_id' => 123, 'offer_id' => 7, 'field' => lead}).should have_been_made.once
    end

    it 'should make the request without peer verification' do
      pending
    end

    it 'should return JSON parsed body' do
      @response.should eq({'result' => 'test'})
    end
  end

  describe '.token' do
    def beeleads_token(params)
      Beeleads::Client.class_eval { token('yoursecret', params) }
    end

    it 'should return the correct token' do
      beeleads_token({ :email => 'sample@example.net', :firstname => 'Tiago' }).should eq('534da26a597e62b65b25711eb200197fc59ceb14')
    end

    it 'should return the same token when the params order are different' do
      beeleads_token({ :email => 'sample@example.net', :firstname => 'Tiago' }).
        should eq(beeleads_token({ :firstname => 'Tiago', :email => 'sample@example.net' }))
    end
  end

  describe '.token_query' do
    it 'should return the correct encoded form data' do
      Beeleads::Client.class_eval { token_query({ :email => 'sample@example.net', :firstname => 'Tiago' }) }.should eq('email=sample%40example.net&firstname=Tiago')
    end

    it 'has keys in alphabetical order' do
      Beeleads::Client.class_eval { token_query({ :firstname => 'Tiago', :email => 'sample@example.net' }) }.should eq('email=sample%40example.net&firstname=Tiago')
    end
  end
end
