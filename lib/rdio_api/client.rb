require 'forwardable'

module RdioApi
  
  class Client
    
    include Core
    
    attr_reader :consumer_key, :consumer_secret, :access_token
    
    # Initialize the client for API request. A consumer key and consumer secret are required. 
    # Requests on behalf of the user require access_token (oauth token)
    
    def initialize(options={})
      @consumer_key    = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @access_token    = options[:access_token]
    end
    
    # Set up the connection to use for all requests based on the options from intialization. 
    
    def connection
      params = {}
      params[:consumer_key] = @consumer_key if @consumer_key
      params[:consumer_secret] = @consumer_secret if @consumer_secret
      params[:access_token] = @access_token if @access_token
      @connection ||= Faraday::Connection.new(:url => api_url) do |builder|
        builder.use Faraday::Request::OAuth2, params
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::Mashify 
        builder.use Faraday::Response::ParseJson
        builder.adapter Faraday.default_adapter
      end
    end
    
    # Base URL for api requests
    
    def api_url
      ("http://api.rdio.com/1/").freeze
    end
    
    def check_response_for_errors(response)
     response.body.status == "ok" ? response.body.result : response.body.message
    end
  end
end