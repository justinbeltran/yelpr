require File.expand_path('../../../lib/yelpr/client', __FILE__)
require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../../support/vcr', __FILE__)

describe Yelpr::Client do

  before do
    VCR.insert_cassette __name__
    @client = Yelpr::Client.new(
      :consumer_key    => 'your_credentials_go_here',
      :consumer_secret => 'your_credentials_go_here',
      :token           => 'your_credentials_go_here',
      :token_secret    => 'your_credentials_go_here'
    )
  end

  after do
    VCR.eject_cassette
  end

  it 'can get an error response if no OAuth' do
    noauth_client = Yelpr::Client.new
    response = noauth_client.search
    response.error.text.must_match /One or more parameters are missing in request/
    response.error.id.must_match /MISSING_PARAMETER/
    response.error.field.must_match /oauth_consumer_key/
  end

  it 'can get search results based on parameters' do
    response = @client.search(
      :term     => 'food',
      :location => 'Irvine, CA',
      :limit    => 5
    )

    response.businesses.size.must_equal 5
  end

  it 'can get specific business results by id' do
    response = @client.business('yelp-san-francisco')

    response.categories.wont_be_empty
    response.reviews.wont_be_empty
    response.location.wont_be_nil
    response.rating.wont_be_nil
    response.id.must_match /yelp-san-francisco/
  end

end
