require 'multi_json'
require 'hashie'

module RdioApi
  
  module Api
    
    def method_missing(method_name, *arguments)
       if UNAUTHENTICATED.include?(method_name.to_sym)
         response = unauthenticated_connection.post do |request|
           request.body = {:method => method_name.to_s}.merge!(Hash[*arguments.flatten])
         end
         response.body.result
       elsif AUTHENTICATED.include?(method_name.to_sym)
         Hashie::Mash.new(MultiJson.decode(authenticated_connection.post(api_url, 
                                            {:method => method_name.to_s}.merge!(Hash[*arguments.flatten])).body)['result'])
       else
         "Unkown Method, please refer to http://developer.rdio.com/docs/read/rest/Methods for a list"
       end
    end

    UNAUTHENTICATED = [
      :get,
      :getAlbumsForArtist,
      :getTracksForArtist,
      :search,
      :searchSuggestions,
      :getAlbumsForArtistInCollection,
      :getAlbumsInCollection,
      :getArtistsInCollection,
      :getTracksForAlbumInCollection,
      :getTracksForArtistInCollection,
      :getTracksInCollection,
      :findUser,
      :userFollowers,
      :userFollowing,
      :getActivityStream,
      :getHeavyRotation,
      :getNewReleases,
      :getTopCharts,
      :getPlaybackToken]
      
    AUTHENTICATED = [
      :getObjectFromShortCode,
      :getObjectFromUrl,
      :addToCollection,
      :removeFromCollection,
      :addToPlaylist,
      :createPlaylist,
      :deletePlaylist,
      :getPlaylists,
      :removeFromPlaylist,
      :setPlaylistCollaborating,
      :setPlaylistCollaborationMode,
      :setPlaylistFields,
      :setPlaylistOrder,
      :addFriend,
      :currentUser,
      :removeFriend]
  end
end
