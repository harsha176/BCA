#
# This model is used to store session. Every time user login a session is created.
# It contains following fieldS
#    2. User_id of the user who created the post.
#
class Session < ActiveRecord::Base
  belongs_to :user
end

