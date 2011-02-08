require File.dirname(__FILE__) + '/../spec_helper'

describe Tweet do
  describe "Validations" do
    before(:each) do
      @tweet = Tweet.new(:user => User.new, :text => "text")
    end
    it "should not save if user is empty" do
      @tweet.user = nil
      @tweet.valid?.should be_false
      @tweet.should have(1).error_on(:user)
    end

    it "should not save if text is more than 140 characters" do
      @tweet.text = "a"*150
      @tweet.valid?.should be_false
      @tweet.should have(1).error_on(:text)
    end

    it "should not save if text is empty" do
      @tweet.text = ""
      @tweet.valid?.should be_false
      @tweet.should have(1).error_on(:text)
    end
  end
end
