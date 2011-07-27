$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'rdio_api'
require 'rspec'
require 'webmock/rspec'

def stub_post
  stub_request(:post, "http://api.rdio.com/1/")
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end