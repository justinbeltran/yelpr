require File.expand_path('../../../lib/yelpr/client', __FILE__)
require File.expand_path('../../spec_helper', __FILE__)
require File.expand_path('../../support/vcr', __FILE__)

describe Yelpr::Client do

  before do
    VCR.insert_cassette __name__
  end

  after do
    VCR.eject_cassette
  end

  it 'can get an error response if no OAuth' do
    client = Yelpr::Client.new
    response = client.search
    response.error.text.must_match /One or more parameters are missing in request/
    response.error.id.must_match /MISSING_PARAMETER/
    response.error.field.must_match /oauth_consumer_key/
  end

  it 'can get results based on parameters' do
    client = Yelpr::Client.new(
      :consumer_key    => 'use_your_consumer_key',
      :consumer_secret => 'use_your_consumer_secret',
      :token           => 'use_your_token',
      :token_secret    => 'use_your_token_secret'
    )

    response = client.search(
      :term     => 'food',
      :location => 'Irvine, CA',
      :limit    => 5
    )

    response.businesses.size.must_equal 5
  end
end
