require 'helper'

describe RdioApi::Client do
  
  context "when working with the Core methods" do
    before do
      @client = RdioApi.new(:consumer_key => "consumerkey", :consumer_secret => "consumersecret")
    end
    
    context "and methods that do not require authentication" do
      
      describe "'get'" do

        context "with keys passed" do
          before do
            stub_post.with(:body => {:method => 'get', :keys => "r13700"}).
              to_return(:body => fixture("get.json"))
          end

          it "should have the correct Artist name" do
            results = @client.get(:keys => "r13700")
            results.r13700.name.should eq("John Williams")
          end
        end
      end
    end

    
    context "and methods that require authentication " do
      
      let(:access_token) do
        @client.authorized_connection
        @client.authorized_connection.post
      end
      
      describe "'getObjectFromShortCode'" do

        before do
          stub_post.with(:body => {:method => 'getObjectFromShortCode', :short_code => "QisyLj0"}).
            to_return(:body => fixture("getObjectFromShortCode.json"))
        end
        
        it "should have the correct Track name " do
          results = @client.getObjectFromShortCode(:short_code => "QisyLj0")
          results.name.should eq("Loud Pipes")
        end
      end
    end
  end
end