module RdioApi
  
  module Api
    
    def method_missing(method_name)
      response = connection.post do |request|
        request.body = { :method => method_name.to_s}
      end
    end
  end
end