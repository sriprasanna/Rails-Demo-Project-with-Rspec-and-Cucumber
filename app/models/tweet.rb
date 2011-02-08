class Tweet < ActiveRecord::Base
  belongs_to :user
  cattr_reader :per_page
  @@per_page = 10

  default_scope order("created_at DESC")

  validates :user, :presence => true
  validates :text, :length => 1..140 
end
