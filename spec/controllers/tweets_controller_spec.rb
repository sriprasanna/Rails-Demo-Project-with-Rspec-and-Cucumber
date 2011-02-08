require File.dirname(__FILE__) + '/../spec_helper'

describe TweetsController do
  fixtures :all
  render_views

  before(:each) do
    @user = User.new
    @controller.stubs(:current_user).returns(@user)
  end

  it "create action should redirect when model is valid" do
    Tweet.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_path)
  end


  it "destroy action should destroy model and redirect to index action" do
    tweet = Tweet.first
    delete :destroy, :id => tweet
    response.should redirect_to(tweets_url)
    Tweet.exists?(tweet.id).should be_false
  end
end
