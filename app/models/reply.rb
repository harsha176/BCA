class Reply < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :reply
  belongs_to :replies_users
  has_and_belongs_to_many :users
end
