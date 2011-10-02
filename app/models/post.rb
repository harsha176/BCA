class Post < ActiveRecord::Base
  has_many :replies
  has_and_belongs_to_many :users

  validates_presence_of :title
  validates_presence_of :message
  validates_presence_of :user_id
end
