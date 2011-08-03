require 'helper'

describe RdioApi::Client do
  
  context "when working with the Activity methods" do
    before do
      @client = RdioApi.new(:consumer_key => "consumerkey", :consumer_secret => "consumersecret")
    end
   
    describe "'getActivityStream'" do
      before do
        stub_post.with(:body => {:method => 'getActivityStream', :user => "s27093", :scope => "user"}).
          to_return(:body => fixture("getActivityStream.json"))
      end
      
      it "should have the correct user library version" do
        results = @client.getActivityStream(:user => "s27093", :scope => "user")
        results.user.libraryVersion.should eq(110)
      end
    end
    
    describe "'getHeavyRotation'" do
      before do
        stub_post.with(:body => {:method => 'getHeavyRotation', :type => "albums"}).
          to_return(:body => fixture("getHeavyRotation.json"))
      end
      
      it "should return all 10 albums" do
        results = @client.getHeavyRotation(:type => "albums")
        results.count.should eq(10)
      end
    end
    
    describe "'getNewReleases'" do
      before do
        stub_post.with(:body => {:method => 'getNewReleases', :type => "thisweek"}).
          to_return(:body => fixture("getNewReleases.json"))
      end
      
      it "should return the correct name for the first album" do
        results = @client.getNewReleases(:type => "thisweek")
        results.first.name.should eq("King (Deluxe Version)")
      end
    end
    
    describe "'getTopCharts'" do
      before do
        stub_post.with(:body => {:method => 'getTopCharts', :type => "Playlist"}).
          to_return(:body => fixture("getTopCharts.json"))
      end
      
      it "should return the correct Playlists" do
        results = @client.getTopCharts(:type => "Playlist")
        results.count.should eq(11)
        results.first.name.should eq("Billboard Top 100")
      end
    end
  end
end