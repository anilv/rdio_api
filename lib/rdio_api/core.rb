module RdioApi
  
  module Core
    
    def get(keys, extras=nil)
      response = connection.post do |request|
        request.body = { :method => 'get', :keys => keys, :extras => extras}
      end
      check_response_for_errors(response)
    end
    
    def getObjectFromShortCode(short_code)
      response = connection.post do |request|
        request.body = { :method => 'getObjectFromShortCode', :short_code => short_code}
      end
      check_response_for_errors(response)
    end
    
    def getObjectFromUrl(url)
      response = connection.post do |request|
        request.body = { :method => 'getObjectFromUrl', :url => url}
      end
      check_response_for_errors(response)
    end
  end
end