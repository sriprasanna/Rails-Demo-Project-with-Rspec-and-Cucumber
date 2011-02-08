require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to("/")
    session['user_id'].should == assigns['user'].id
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    @controller.stubs(:current_user).returns(User.first)
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when user is invalid" do
    @controller.stubs(:current_user).returns(User.first)
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when user is valid" do
    @controller.stubs(:current_user).returns(User.first)
    User.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    response.should redirect_to("/")
  end

  it "should get user tweets and his followings tweets" do
    @controller.stubs(:current_user).returns(User.first)
    user = User.first
    Tweet.create!(:user => user, :text => "text")
    following = User.last
    Tweet.create!(:user => following, :text => "text")
    Follow.create!(:follower => user, :user => following)
    get :index
    assigns(:tweets).should_not be_nil
    assigns(:tweets).count.should == 2
  end

  it "should render user's profile page" do
    @controller.stubs(:current_user).returns(User.first)
    user = User.last
    Tweet.create!(:user => user, :text => "text")
    get :show, :id => User.last.id
    assigns(:user).should == User.last
    assigns(:tweets).count.should == 1
  end

  it "should add a user to following list" do
    @controller.stubs(:current_user).returns(User.first)
    Follow.count.should == 0
    get :toggle_follow, :id => User.last.id
    Follow.count.should == 1
    response.should redirect_to User.last
  end

  it "should remove a user from following list if already exists" do
    @controller.stubs(:current_user).returns(User.first)
    Follow.create!(:user => User.last, :follower => User.first)
    Follow.count.should == 1
    get :toggle_follow, :id => User.last.id
    Follow.count.should == 0
    response.should redirect_to User.last
  end

end
