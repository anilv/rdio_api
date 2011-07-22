require "rdio_api/version"
require 'faraday'
require 'faraday_middleware'

require 'rdio_api/api'

module RdioApi
  
  # RdioApi::Client.new alias
  def self.new(options={})
    RdioApi::Client.new(options)
  end
end
