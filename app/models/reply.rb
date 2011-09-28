class Reply < ActiveRecord::Base
  belongs_to:post
  validates_presence_of :reply
end
