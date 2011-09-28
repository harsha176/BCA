class User < ActiveRecord::Base
  has_many:posts
  has_one:session
end
