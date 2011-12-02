require 'faraday'
require 'faraday_middleware'

module Yelpr
  class Client

    attr_accessor :consumer_key, :consumer_secret, :token, :token_secret

    def initialize()
      yield self

      @conn = Faraday.new(:url => 'http://api.yelp.com') do |builder|
        builder.use Faraday::Request::OAuth, auth if auth.values.all?
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
        builder.adapter Faraday.default_adapter
      end
    end

    def search(options = {})
      response = @conn.get do |request|
        request.url '/v2/search', options
      end

      response.body
    end
    
    def business(id)
      response = @conn.get "/v2/business/#{id}"
      response.body
    end

    private

    def auth
      {
        :consumer_key    => @consumer_key,
        :consumer_secret => @consumer_secret,
        :token           => @token,
        :token_secret    => @token_secret
      }
    end
  end
end
