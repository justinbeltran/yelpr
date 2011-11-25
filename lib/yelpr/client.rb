require 'faraday'

module Yelpr
  class Client

    def initialize
      @conn = Faraday.new(:url => 'http://api.yelp.com') do |builder|
        builder.request  :url_encoded
        builder.request  :json
        builder.adapter  :net_http
      end
    end

    def search(options = {})
      response = @conn.get 'v2/search'
      response.body
    end
  end
end
