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
      before do
        @client.access_token = test_access_token
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
      
      describe "'getObjectFromUrl'" do
        before do
          stub_post.with(:body => {:method => 'getObjectFromUrl', :url => "/artist/James_Horner/" }).
            to_return(:body => fixture("getObjectFromUrl.json"))
        end
        
        it "should have the corrent topSongsKey" do
          results = @client.getObjectFromUrl(:url => "/artist/James_Horner/")
          results.topSongsKey.should eq("tr35187")
        end
      end
    end
  end
end