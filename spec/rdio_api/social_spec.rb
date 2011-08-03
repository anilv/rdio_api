require 'helper'

describe RdioApi::Client do
  
  context "when working with the Social methods" do
    before do
      @client = RdioApi.new(:consumer_key => "consumerkey", :consumer_secret => "consumersecret")
    end
    
    context "and methods that require authentication " do
      before do
        @client.access_token = test_access_token
      end
      
      describe "'addFriend'" do
        before do
          stub_post.with(:body => {:method => 'addFriend', :user => "s12345"}).
            to_return(:body => fixture("addFriend.json"))
        end
        
        it "should add Friend" do
          results = @client.addFriend(:user => "s12345")
          results.should eq("true")
        end
      end
      
      describe "'removeFriend'" do
        before do
          stub_post.with(:body => {:method => 'removeFriend', :user => "s12345"}).
            to_return(:body => fixture("removeFriend.json"))
        end
        
        it "should remove Friend" do
          results = @client.removeFriend(:user => "s12345")
          results.should eq("true")
        end
      end
      
      describe "'currentUser'" do
        before do
          stub_post.with(:body => {:method => 'currentUser'}).to_return(:body => fixture("currentUser.json"))
        end
        
        it "should have the current First Name" do
          results = @client.currentUser
          results.firstName.should eq("Anil")
        end
      end
    end
    
    context "and methods that do not require authentication" do
      
      describe "'findUser'" do
        before do
          stub_post.with(:body => {:method => 'findUser', :vanityName => "anilv"}).
            to_return(:body => fixture("findUser.json"))
        end
        
        it "should have the correct firt name" do
          results = @client.findUser(:vanityName => "anilv")
          results.firstName.should eq("Anil")
        end
      end
      
      describe "'userFollowers'" do
        before do
          stub_post.with(:body => {:method => 'userFollowers', :user => "s12345"}).
            to_return(:body => fixture("userFollowers.json"))
        end
        
        it "should have the correct Name for the first follower" do
          results = @client.userFollowers(:user => "s12345")
          results.count.should eq(2)
          (results.first.firstName + " " + results.first.lastName).should eq("Ruby Githubber")
        end
      end
      
      describe "'userFollowing'" do
        before do
          stub_post.with(:body => {:method => 'userFollowing', :user => "s12345"}).
            to_return(:body => fixture("userFollowing.json"))
        end
        
        it "should have the correct Name for the last follower" do
          results = @client.userFollowing(:user => "s12345")
          results.count.should eq(2)
          (results.last.firstName + " " + results.last.lastName).should eq("Rdio Api")
        end
      end
    end
  end
end