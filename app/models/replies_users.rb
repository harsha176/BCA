#
# This model stores reply votes casted by user.
# Its essentially join of replies and users table.
# Each entry in this table/model indicates that particular
# user has voted for a particular reply.

class RepliesUsers < ActiveRecord::Base
  # Specifying join operations.
  belongs_to :reply
  belongs_to :user

  # This method evaluates the vote count
  # for a particular reply by all the users.
  def RepliesUsers.get_vote_count(reply_id)
    RepliesUsers.find_all_by_reply_id(reply_id).count
  end

  #
  # This method performs vote operation. Given that a user has
  # voted for that particular reply. It maintains user_id and reply_id entry in database.
  #
  def RepliesUsers.vote(user_id, reply_id)
    # Ensuring that user who created the vote is not voting it.
    if Reply.find(reply_id).user_id == user_id
      "Its the user own reply and therefore cannot vote"
    # Ensuring that user is not casting vote again.
    elsif RepliesUsers.find_by_user_id_and_reply_id(user_id, reply_id)
        "User has already voted"
    # Creating and adding an entry in posts_users table which indicates that a user with "user_id" has voted for a post of "reply_id".
    else
      a_post = RepliesUsers.new
      a_post.user_id = user_id
      a_post.reply_id = reply_id
      a_post.has_voted= "true"

      a_post.save
    end
  end
end
