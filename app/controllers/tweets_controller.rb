class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(params[:tweet])
    if @tweet.save
      flash[:notice] = "Successfully created tweet."
      redirect_to @tweet
    else
      render :action => 'new'
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update_attributes(params[:tweet])
      flash[:notice] = "Successfully updated tweet."
      redirect_to tweet_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice] = "Successfully destroyed tweet."
    redirect_to tweets_url
  end
end
