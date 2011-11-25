require File.expand_path('../../../lib/yelpr/client', __FILE__)
require File.expand_path('../../spec_helper', __FILE__)

describe Yelpr::Client do
  it 'can get an error response if no OAuth' do
    client = Yelpr::Client.new
    response = client.search
    response.must_match /error/
    response.must_match /MISSING_PARAMETER/
    response.must_match /oauth_consumer_key/
  end
end
