Rdio Ruby Gem
====================
Ruby wrapper for the Rdio.com API. Inspired from [Linkedin gem](https://github.com/pengwynn/linkedin) & [Twitter gem](https://github.com/jnunemaker/twitter). 


Installation
------------
    gem install rdio_api


Usage
-----

Register for developer keys at [http://developer.rdio.com/](http://developer.rdio.com/).

All the methods are exactly as in the [API docs](http://developer.rdio.com/docs/read/rest/Methods), camel cased and all the endpoints are also exactly the same.

OAuth flow is not part of this gem. Recommend using [OmniAuth](https://github.com/intridea/omniauth) a fantastic gem. Also check Rdio [OAuth documentation](http://developer.rdio.com/docs/read/rest/oauth).


Usage Examples
--------------
    require "rubygems"
    require "rdio_api"

    # Initialize a new Rdio client
    client = RdioApi.new(:consumer_key => CONSUMER_KEY, :consumer_secret => CONSUMER_SECRET)

    # Get songs in heavy rotation
    client.getHeavyRotation(:type => "albums")

	# Get top playlists
	client.getTopCharts(:type => "Playlist")
	
	# Search for a query and and pass in the type
	client.search(:query => "michael giacchino", :types => "album")
	
	# Get activity stream of a user
	client.getActivityStream(:user => "s12345", :scope => "user")
	
	# Find a user by email address 
	client.findUser(:email => "email@example.com")
	
	# Methods that act on behalf of a user require an access token, 
	# [OmniAuth](https://github.com/intridea/omniauth) is best for this
	
	# Access token can be set at initialization 
	client = RdioApi.new(:consumer_key => CONSUMER_KEY, 
						 :consumer_secret => CONSUMER_SECRET, 
						 :access_token => ACCESS_TOKEN)
	# Access token can also be set at the clien't access_token instance variable
	client.access_token = ACCESS_TOKEN
	
	# Get info about the current user 
	client.currentUser
	
	# Add a friend
	client.addFriend(:user => "s12345")
	
	# Create a Playlist
	client.createPlaylist(:name => "RubyGem", 
	                      :description => "Testing", 
	                      :tracks => "t1945474, t3483614")	

Available Methods
-----------------	
	
	# Unauthenticated methods, which only require registering for developer keys
	client.get
    client.getAlbumsForArtist
    client.getTracksForArtist
    client.search
    client.searchSuggestions
    client.getAlbumsForArtistInCollection
    client.getAlbumsInCollection
    client.getArtistsInCollection
    client.getTracksForAlbumInCollection
    client.getTracksForArtistInCollection
    client.getTracksInCollection
    client.findUser
    client.userFollowers
    client.userFollowing
    client.getActivityStream
    client.getHeavyRotation
    client.getNewReleases
    client.getTopCharts
    client.getPlaybackToken

	# Authenticated methods, which require an access token , obtained with user permission
	client.getObjectFromShortCode
    client.getObjectFromUrl
    client.addToCollection
    client.removeFromCollection
    client.setAvailableOffline
    client.addToPlaylist
    client.createPlaylist
    client.deletePlaylist
    client.getPlaylists
    client.removeFromPlaylist
    client.setPlaylistCollaborating
    client.setPlaylistCollaborationMode
    client.setPlaylistFields
    client.setPlaylistOrder
    client.addFriend
    client.currentUser
    client.removeFriend

TODO
----
* Explore moving methods from camel case to snake case and update tests accordingly
* OAuth flow
* More tests for methods and for each endpoints
* Test and Support multiple Rubies


