class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  
  def index
    @tweets = Tweet.where(:user_id => [current_user.id] + current_user.following.collect(&:user_id)).paginate(:page => params[:page]) 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to "/"
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your profile has been updated."
      redirect_to "/"
    else
      render :action => 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.paginate(:page => params[:page])
  end

  def toggle_follow
    where = {:user_id => params[:id], :follower_id => current_user.id}
    if follow = Follow.where(where).first
      follow.destroy
    else
      follow = Follow.create!(where)
    end
    redirect_to follow.user 
  end
end
