class RepliesUsers < ActiveRecord::Base
  belongs_to :reply
  belongs_to :user

  def RepliesUsers.get_vote_count(reply_id)
    RepliesUsers.find_all_by_reply_id(reply_id).count
  end

  def RepliesUsers.vote(user_id, reply_id)
    if Reply.find(reply_id).user_id == user_id
      "Its the user own post and therefore cannot vote"
    elsif RepliesUsers.find_by_user_id_and_reply_id(user_id, reply_id)
        "User has already voted"
    else
      a_post = RepliesUsers.new
      a_post.user_id = user_id
      a_post.reply_id = reply_id
      a_post.has_voted= "true"

      a_post.save
    end
  end
end
