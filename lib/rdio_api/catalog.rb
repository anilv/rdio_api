module RdioApi
  
  module Catalog
    
    def getAlbumsForArtist(artist, featuring=nil, extras=nil, start=nil, count=nil)
      response = connection.post do |request|
        request.body = { :method => 'getAlbumsForArtist',
                         :artist => artist,
                         :featuring => featuring, 
                         :extras => extras,
                         :start => start,
                         :count => count }
      end
      check_response_for_errors(response)
    end
    
    def getTracksForArtist(artist, appears_on=nil, extras=nil, start=nil, count=nil)
      response = connection.post do |request|
        request.body = { :method => 'getTracksForArtist', 
                         :artist => artist,
                         :appears_on => featuring, 
                         :extras => extras,
                         :start => start,
                         :count => count }
      end
      check_response_for_errors(response)
    end
    
    def search(arguments={})
      response = connection.post do |request|
        request.body = { :method => 'search',
                         :arguments => arguments }
      end
    end
    
    def searchSuggestions(query, extras=nil)
      response = connection.post do |request|
        request.body = { :method => 'searchSuggestions',
                         :query => query,
                         :extras => extras }
      end
    end
  end  
end