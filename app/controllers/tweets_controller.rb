class TweetsController < ApplicationController
  before_filter :login_required

  def create
    @tweet = Tweet.new(params[:tweet])
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = "Successfully created tweet."
    else
      flash[:error] = "OOPS! Something went wrong!"
    end
    redirect_to :root
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice] = "Successfully destroyed tweet."
    redirect_to tweets_url
  end
end
