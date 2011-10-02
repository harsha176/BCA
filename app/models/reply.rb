class Reply < ActiveRecord::Base
  belongs_to :post

  belongs_to :replies_users
  has_and_belongs_to_many :users

  validates_presence_of :reply
  validates_presence_of :post_id
end
