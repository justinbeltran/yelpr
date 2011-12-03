require File.expand_path('../../../lib/yelpr/client', __FILE__)
require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../../support/vcr', __FILE__)

describe Yelpr::Client do

  before do
    VCR.insert_cassette(__name__, :record => :new_episodes)
    @client = Yelpr::Client.new do |c|
      c.consumer_key    = 'consumer_key'
      c.consumer_secret = 'consumer_secret'
      c.token           = 'token'
      c.token_secret    = 'token_secret'
    end
  end

  after do
    VCR.eject_cassette
  end

  describe "when created" do
    it 'gets an error response if OAuth credentials are missing' do
      noauth_client = Yelpr::Client.new { } 
      response = noauth_client.search
      response.error.text.must_match /One or more parameters are missing in request/
      response.error.id.must_match /MISSING_PARAMETER/
      response.error.field.must_match /oauth_consumer_key/
    end
  end 

  describe "when searching for businesses" do
    it 'gets search results based on parameters' do
      response = @client.search(
        :term     => 'food',
        :location => 'Irvine, CA',
        :limit    => 5
      )
      response.businesses.size.must_equal 5
    end
  end

  describe "when finding business by id" do
    it "gets specific business results by id" do
      response = @client.business('yelp-san-francisco')

      response.categories.wont_be_empty
      response.reviews.wont_be_empty
      response.location.wont_be_nil
      response.rating.wont_be_nil
      response.id.must_match /yelp-san-francisco/
    end
  end 

end
