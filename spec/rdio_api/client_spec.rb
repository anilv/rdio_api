require 'helper'

describe RdioApi::Client do
  
  context "When initializing a new instance" do
    
    it "should keep oauth token for requests" do
      @client = RdioApi.new(:access_token => 'rdiooauth')
      @client.access_token.should eq('rdiooauth')
    end

    it "should keep consumer key/secret for requests" do
      @client = RdioApi.new(:consumer_key => "consumerkey", :consumer_secret => "consumersecret")
      @client.consumer_key.should eq("consumerkey")
      @client.consumer_secret.should eq("consumersecret")
    end
  end
end