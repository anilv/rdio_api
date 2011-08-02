$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'rdio_api'
require 'rspec'
require 'webmock/rspec'
require 'oauth'

def stub_post
  stub_request(:post, "http://api.rdio.com/1/")
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def test_consumer
  @test_consumer ||= OAuth::Consumer.new("consumer_key", "consumer_secret")
end

def test_access_token
  @test_access_token ||= OAuth::AccessToken.new(test_consumer, "auth_token", "auth_secret")
end