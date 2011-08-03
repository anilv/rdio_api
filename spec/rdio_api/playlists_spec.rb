require 'helper'

describe RdioApi::Client do
  
  context "when working with the Playlist methods" do
    before do
      @client = RdioApi.new(:consumer_key => "consumerkey", 
                            :consumer_secret => "consumersecret",
                            :access_token => test_access_token)
    end
    
    describe "'createPlaylist'" do
      before do
        stub_post.with(:body => {:method => 'createPlaylist', :name => "RubyGem", 
                                 :description => "Testing", :track => "t1945474, t3483614"}).
          to_return(:body => fixture("createPlaylist.json"))
      end
      
      it "should create the playlist and have the correct name" do
        results = @client.createPlaylist(:name => "RubyGem", :description => "Testing", :track => "t1945474, t3483614")
        results.name.should eq("RubyGem")
      end
    end
    
    describe "'addToPlaylist'" do
      before do
        stub_post.with(:body => {:method => 'addToPlaylist', :playlist => "p200057", :tracks => "t1945475"}).
          to_return(:body => fixture("addToPlaylist.json"))
      end
      
      it "should add to track to playlist" do
        results = @client.addToPlaylist(:playlist => "p200057", :tracks => "t1945475")
        results.should eq("true")
      end
    end
    
    describe "'getPlaylists'" do
      before do
        stub_post.with(:body => {:method => 'getPlaylists'}).to_return(:body => fixture("getPlaylists.json"))
      end
      
      it "should return the playlist created in 'createPlaylist'" do
        results = @client.getPlaylists
        results.owned.first.name.should eq("RubyGem")
      end
    end
    
    describe "'setPlaylistCollaborating'" do
      before do
        stub_post.with(:body => {:method => 'setPlaylistCollaborating', :playlist => "p200057", :collaborating => "false"}).
          to_return(:body => fixture("setPlaylistCollaborating.json"))
      end
      
      it "should return true(collaborating should be false)" do
        results = @client.setPlaylistCollaborating(:playlist => "p200057", :collaborating => "false")
        results.should eq("true")
      end
    end
    
    describe "'setPlaylistCollaborationMode'" do
      before do
        stub_post.with(:body => {:method => 'setPlaylistCollaborationMode', :playlist => "p200057", :mode => "2"}).
          to_return(:body => fixture("setPlaylistCollaborationMode.json"))
      end
      
      it "should set collaboration mode to playlist followers and return true" do
        results = @client.setPlaylistCollaborationMode(:playlist => "p200057", :mode => "2")
        results.should eq("true")
      end
    end
    
    describe "'setPlaylistFields'" do
      before do
        stub_post.with(:body => {:method => 'setPlaylistFields', :playlist => "p200057",
                                 :name => "RdioApi RubyGem", :description => "A Test Playlist"}).
          to_return(:body => fixture("setPlaylistFields.json"))
      end
      
      it "should change Playlist fields" do
        results = @client.setPlaylistFields(:playlist => "p200057", :name => "RdioApi RubyGem", :description => "A Test Playlist")
        results.should eq("true")
      end
    end
    
    describe "'setPlaylistOrder'" do
      before do
        stub_post.with(:body => {:method => 'setPlaylistOrder', :playlist => "p200057", :track => "t3483614, t1945474, t1945475"}).
          to_return(:body => fixture("setPlaylistOrder.json"))
      end
      
      it "should set new Playlist order " do
        results = @client.setPlaylistOrder(:playlist => "p200057", :track => "t3483614, t1945474, t1945475")
        results.should eq("true")
      end
    end
    
    describe "'removeFromPlaylist'" do
      before do
        stub_post.with(:body => {:method => 'removeFromPlaylist', :playlist => "p200057", :index => "2",
                                 :count => "1", :tracks => "t1945475"}).
          to_return(:body => fixture("removeFromPlaylist.json"))
      end
      
      it "should remove track from Playlist" do
        results = @client.removeFromPlaylist(:playlist => "p200057", :index => "2", :count => "1", :tracks => "t1945475")
        results.should eq("true")
      end
    end
    
    describe "'deletePlaylist'" do
      before do
        stub_post.with(:body => {:method => 'deletePlaylist', :playlist => "p200057"}).
          to_return(:body => fixture("deletePlaylist.json"))
      end
      
      it "should delete the playlist" do
        results = @client.deletePlaylist(:playlist => "p200057")
        results.should eq("true")
      end
    end
  end
end