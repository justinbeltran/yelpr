Yelpr
===========

[![Build Status](https://secure.travis-ci.org/justinbeltran/yelpr.png)](http://travis-ci.org/justinbeltran/yelpr)

Yelpr is a yelp gem for the masses.  In general, it's just a wrapper on top of the existing Yelp v2 API.

Before you use Yelpr and Yelp's v2 API, you must set up API OAuth access on the following page:

[http://www.yelp.com/developers/getting_started/api_access](http://www.yelp.com/developers/getting_started/api_access)

See the following for reference, when using the client:

[http://www.yelp.com/developers/documentation/v2/overview](http://www.yelp.com/developers/documentation/v2/overview)

Installation
------------
```bash
gem install yelpr
```

Usage
------------

After you provide your API credentials, you can make pass API params to
the search method.  For example to search for the first 5 results for
"food" in Los Angeles, you would do the following:

```ruby
client = Yelpr::Client.new do |c|
	c.consumer_key    = 'consumer_key'
	c.consumer_secret = 'consumer_secret'
	c.token           = 'token'
	c.token_secret    = 'token_secret'
end

results = client.search(:term => 'food', :location => 'Los Angeles, CA', :limit => 5)
```
