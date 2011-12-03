# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "yelpr/version"

Gem::Specification.new do |s|
  s.name        = "yelpr"
  s.version     = Yelpr::VERSION
  s.authors     = ["Justin Beltran"]
  s.email       = ["justinvbeltran@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Yelp API v2.0 Ruby gem}
  s.description = %q{Yelp gem for the masses.}

  s.rubyforge_project = "yelpr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "webmock"
  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "vcr"
  s.add_runtime_dependency "faraday"
  s.add_runtime_dependency "faraday_middleware"
  s.add_runtime_dependency "hashie"
  s.add_runtime_dependency "multi_json"
  s.add_runtime_dependency "yajl-ruby"
  s.add_runtime_dependency "simple_oauth"
end
