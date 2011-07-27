require 'helper'

describe RdioApi::Client do
  
  context "when working with the Core methods" do
    before do
      @client = RdioApi::Client.new(:consumer_key => "consumerkey", :consumer_secret => "consumersecret")
    end
    
    describe "'get'" do
      
      context "with keys passed" do
        before do
          stub_post.with(:body => {:method => 'get', :keys => "r13700"}).
            to_return(:body => fixture("get.json"))
        end

        it "should have the correct Artist name" do
          results = @client.get(:keys => "r13700").result
          results.r13700.name.should eq("John Williams")
        end
      end
    end
  end
end