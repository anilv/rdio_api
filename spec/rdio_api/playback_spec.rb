require 'helper'

describe RdioApi::Client do
  
  context "when working with the Playback methods" do
    before do
      @client = RdioApi.new(:consumer_key => "consumerkey", :consumer_secret => "consumersecret")
    end
    
    describe "'getPlaybackToken'" do
      before do
        stub_post.with(:body => {:method => 'getPlaybackToken'}).
          to_return(:body => fixture("getPlaybackToken.json"))
      end

      it "should return a Playback Token" do
        results = @client.getPlaybackToken
        results.should eq("flkasdjFA5lkdjf90asdfli2l9cnlkasdj9")
      end
    end
  end
end