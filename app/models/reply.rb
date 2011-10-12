#
# This model is used to store replies created by user.
# It contains following fields
#    1. reply
#    2. User_id of the user who created the post.
#
class Reply < ActiveRecord::Base
  #
  # Each reply is associated with a post.
  #
  belongs_to :post

  #
  # This is used for creating votes
  # table(replies_users) which is join of both users and replies table.
  #
  #
  belongs_to :replies_users
  has_and_belongs_to_many :users
  #
  # Performing validations on each field.
  #
  validates_presence_of :reply
  validates_presence_of :post_id
end