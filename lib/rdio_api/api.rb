require 'multi_json'
require 'hashie'

module RdioApi

  module Api

    def method_missing(method_sym, *arguments)
      if UNAUTHENTICATED.include?(method_sym)
        unauthenticated_request(method_sym, *arguments)
      elsif AUTHENTICATED.include?(method_sym)
        authenticated_request(method_sym, *arguments)
      else
        raise NoMethodError.new("Undefined method '#{method_sym}' for #{self}")
      end
    end

    def respond_to?(method)
      AUTHENTICATED.include?(method.to_sym) || UNAUTHENTICATED.include?(method.to_sym) ? true : false
    end

    private

    def unauthenticated_request(method_sym, *arguments)
      response = unauthenticated_connection.post(api_url) do |request|
        request.body = {:method => method_sym.to_s}.merge!(Hash[*arguments.flatten])
      end
      response.body.result
    end

    def authenticated_request(method_sym, *arguments)
      response = authenticated_connection.post(api_url) do |request|
        request.body = {:method => method_sym.to_s}.merge!(Hash[*arguments.flatten])
      end
      response.body.result
    end

    UNAUTHENTICATED = [
      :get,
      :getObjectFromShortCode,
      :getObjectFromUrl,
      :getAlbumsForArtist,
      :getTracksForArtist,
      :getTracksByISRC,
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
      :getUserPlaylists,
      :getPlaybackToken]

    AUTHENTICATED = [
      :addToCollection,
      :removeFromCollection,
      :setAvailableOffline,
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
