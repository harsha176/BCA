#
# This model is used to store posts created by user.
# It contains following fields
#    1. Title
#    2. Message
#    3. User_id of the user who created the post.
#
class Post < ActiveRecord::Base
  #
  # Each post can have many replies and when a post is deleted
  # then all of its associated replies can also be deleted.
  #
  has_many :replies, :dependent=>:destroy
  #
  # THis is used for creating votes
  # table(posts_users) which is join of both users and posts table.
  #
  #
  has_and_belongs_to_many :users

  #
  # Performing validations on each field.
  #
  validates_presence_of :title
  validates_presence_of :message
  validates_presence_of :user_id
end
