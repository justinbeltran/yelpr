require 'faraday'
require 'faraday_middleware'

module Yelpr
  class Client

    ROOT_PATH            = 'http://api.yelp.com'
    SEARCH_PATH          = '/v2/search'
    BUSINESS_PATH_PREFIX = '/v2/business'

    attr_accessor :consumer_key, :consumer_secret, :token, :token_secret

    def initialize()
      yield self

      @conn = Faraday.new(:url => ROOT_PATH) do |builder|
        builder.use Faraday::Request::OAuth, auth if auth.values.all?
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
        builder.adapter Faraday.default_adapter
      end
    end

    def search(options = {})
      response = @conn.get do |request|
        request.url SEARCH_PATH, options
      end

      response.body
    end
    
    def business(id)
      response = @conn.get "#{BUSINESS_PATH_PREFIX}/#{id}"
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
