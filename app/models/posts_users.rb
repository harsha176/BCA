class PostsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def PostsUsers.get_vote_count(post_id)
    PostsUsers.find_all_by_post_id(post_id).count
  end

  def PostsUsers.vote(user_id, post_id)
    if Post.find(post_id).user_id == user_id
      "Its the user own post and therefore cannot vote"
    elsif PostsUsers.find_by_user_id_and_post_id(user_id, post_id)
        "User has already voted"
    else
      a_post = PostsUsers.new
      a_post.user_id = user_id
      a_post.post_id = post_id
      a_post.has_voted= "true"

      a_post.save
    end
  end
end
