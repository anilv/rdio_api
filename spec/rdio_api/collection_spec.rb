require 'helper'

describe RdioApi::Client do
  
  context "when working with the Collection methods" do
    before do
      @client = RdioApi.new(:consumer_key => "consumerkey", :consumer_secret => "consumersecret")
    end
    
    context "and methods that require authentication " do
      before do
        @client.access_token = test_access_token
      end
      
      describe "'addToCollection'" do
        before do
          stub_post.with(:body => {:method => 'addToCollection', :keys => "t3802391"}).
            to_return(:body => fixture("addToCollection.json"))
        end
        
        it "should add track to Collection" do
          results = @client.addToCollection(:keys => "t3802391")
          results.should eq("true")
        end
      end
      
      describe "'removeFromCollection'" do
        before do
          stub_post.with(:body => {:method => 'removeFromCollection', :keys => "t3802391"}).
            to_return(:body => fixture('removeFromCollection.json'))
        end
        
        it "should remove track from Collection" do
          results = @client.removeFromCollection(:keys => "t3802391")
          results.should eq("true")
        end
      end
      
      describe "'setAvailableOffline'" do
        before do
          stub_post.with(:body => {:method => 'setAvailableOffline', :keys => "t1945474", :offline => "true"}).
            to_return(:body => fixture("setAvailableOffline.json"))
        end
        
        it "should return true with setting track available offline" do
          results = @client.setAvailableOffline(:keys => "t1945474", :offline => "true")
          results.should eq("true")
        end
      end
    end
    
    context "and methods that do not require authentication" do
      
      describe "'getAlbumsForArtistInCollection'" do
        before do
          stub_post.with(:body => {:method => 'getAlbumsForArtistInCollection', :artist => "r350868"}).
            to_return(:body => fixture("getAlbumsForArtistInCollection.json"))
        end
        
        it "should have the correct first track name" do
          results = @client.getAlbumsForArtistInCollection(:artist => "r350868")
          results.first.tracks.first.name.should eq("A Game of Thrones")
        end
      end
      
      describe "'getAlbumsInCollection'" do
        before do
          stub_post.with(:body => {:method => 'getAlbumsInCollection', :user => "s27093"}).
            to_return(:body => fixture("getAlbumsInCollection.json"))
        end
        
        it "should have the correct artist name for the last album in collection" do
          results = @client.getAlbumsInCollection(:user => "s27093")
          results.last.artist.should eq("Ennio Morricone")
        end
      end
      
      describe "'getArtistsInCollection'" do
        before do
          stub_post.with(:body => {:method => 'getArtistsInCollection', :user => "s27093"}).
            to_return(:body => fixture("getArtistsInCollection.json"))
        end
        
        it "should have the correct artist for the first artist in collection" do
          results = @client.getArtistsInCollection(:user => "s27093")
          results.first.name.should eq("Arkngthand")
        end
      end
      
      describe "'getTracksForAlbumInCollection'" do
        before do
          stub_post.with(:body => {:method => 'getTracksForAlbumInCollection', :album => "al216556", :user => "s27093" }).
            to_return(:body => fixture("getTracksForAlbumInCollection.json"))
        end
        
        it "should have the correct short url for the third track in collection" do
          results = @client.getTracksForAlbumInCollection(:album => "al216556", :user => "s27093")
          results[2].shortUrl.should eq("http://rd.io/x/QDaXK2t_hQ")
        end
      end
      
      describe "'getTracksForArtistInCollection'" do
        before do
          stub_post.with(:body => {:method => 'getTracksForArtistInCollection', :artist => "r350868"}).
            to_return(:body => fixture('getTracksForArtistInCollection.json'))
        end
        
        it "should have the correct price for track" do
          results = @client.getTracksForArtistInCollection(:artist => "r350868")
          results.first.price.should eq("0.99")
        end
      end
      
      describe "'getTracksInCollection'" do
        before do
          stub_post.with(:body => {:method => 'getTracksInCollection', :user => "s27093"}).
            to_return(:body => fixture('getTracksInCollection.json'))
        end
        
        it "should return 4 tracks in the Collection" do
          results = @client.getTracksInCollection(:user => "s27093")
          results.count.should eq(4)
        end
      end
    end  
  end
end