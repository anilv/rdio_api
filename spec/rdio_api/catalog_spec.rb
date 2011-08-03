require 'helper'

describe RdioApi::Client do
  
  context "when working with the Catalog methods" do
    before do
      @client = RdioApi.new(:consumer_key => "consumerkey", :consumer_secret => "consumersecret")
    end
    
    describe "'getAlbumsForArtist'" do
      
      context "with artist key passed" do
        before do
          stub_post.with(:body => {:method => 'getAlbumsForArtist', :artist => "r20227"}).
            to_return(:body => fixture("getAlbumsForArtist.json"))
        end

        it "should return Array of Albums" do
          albums = @client.getAlbumsForArtist(:artist => "r20227")
          albums.should be_an Array
          albums.first.name.should eq("My Beautiful Dark Twisted Fantasy")
        end
      end
    end
    
    describe "'getTracksForArtist'" do
      
      context "with artist key passed" do
        before do
          stub_post.with(:body => {:method => 'getTracksForArtist', :artist => "r311065"}).
            to_return(:body => fixture("getTracksForArtist.json"))
        end
        
        it "should return Array of Tracks" do
          tracks = @client.getTracksForArtist(:artist => "r311065")
          tracks.should be_an Array
          tracks.last.duration.should eq(121)
        end
      end
    end
    
    describe "'search'" do
      
      context "with query and types passed" do
        before do
          stub_post.with(:body => {:method => 'search', :query => "michael giacchino", :types => "album"}).
            to_return(:body => fixture("search.json"))
        end
        
        it "should have correct track count" do
          results = @client.search(:query => "michael giacchino", :types => "album")
          results.track_count.should eq(708)
        end
        
        it "should include correct track for a result" do
          results = @client.search(:query => "michael giacchino", :types => "album")
          results.results.first.trackKeys.should include("t9506546")
        end
      end
    end
    
    describe "'searchSuggestions'" do
      
      context "with query passed" do
        before do
          stub_post.with(:body => {:method => 'searchSuggestions', :query => "yoav"}).
            to_return(:body => fixture("searchSuggestions.json"))
        end
        
        it "should the correct radioKey" do
          suggestions = @client.searchSuggestions(:query => "yoav")
          suggestions.first.radioKey.should eq("rr316321")
        end
      end
    end
  end
end