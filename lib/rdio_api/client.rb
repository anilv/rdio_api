module RdioApi
  
  class Client
    
    include Api
    
    attr_reader   :consumer_key, :consumer_secret 
    attr_accessor :access_token
    
    # Initialize the client for API request. A consumer key and consumer secret are required. 
    # Requests on behalf of the user require access_token (oauth token)
    
    def initialize(options={})
      @consumer_key    = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @access_token    = options[:access_token]
      @access_secret   = options[:access_secret]
    end
    
    private

    # Set up the connection to use for all requests based on the options from intialization. 

    def unauthenticated_connection
      params = {}
      params[:consumer_key] = @consumer_key 
      params[:consumer_secret] = @consumer_secret 

      initialize_connection(params)
    end
    
    # Sets the access token to make authenticated calls
    
    def authenticated_connection
      params = {}
      params[:consumer_key] = @consumer_key 
      params[:consumer_secret] = @consumer_secret 
      params[:token] = @access_token 
      params[:token_secret] = @access_secret 

      initialize_connection(params)
    end

    def initialize_connection(params) 
      @connection ||= Faraday.new(:url => api_url) do |builder|
        builder.use Faraday::Request::OAuth, params
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
  end
end
