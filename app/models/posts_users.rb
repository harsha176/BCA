#
# This model stores all the posts a user has voted for.
# Its essentially a join of posts and users table.
# Each entry in this table/model indicates that particular
# user has voted for a particular post.
#
class PostsUsers < ActiveRecord::Base
  # Specifying join operations
  belongs_to :user
  belongs_to :post

  # This method evaluates the vote count
  # for a particular post by all the users.
  def PostsUsers.get_vote_count(post_id)
    PostsUsers.find_all_by_post_id(post_id).count
  end

  #
  # This method performs vote operation. Given that a user has
  # voted for that particular post. It maintains user_id and post_id entry in database.
  #
  def PostsUsers.vote(user_id, post_id)
    # Ensuring that user who created the post is not voting it.
    if Post.find(post_id).user_id == user_id
      "Its the user own post and therefore cannot vote"
    # Ensuring that user is not casting vote again.
    elsif PostsUsers.find_by_user_id_and_post_id(user_id, post_id)
        "User has already voted"
    # Creating and adding an entry in posts_users table which indicates that a user with "user_id" has voted for a post of "post_id".
    else
      a_post = PostsUsers.new
      a_post.user_id = user_id
      a_post.post_id = post_id
      a_post.has_voted= "true"

      a_post.save

      post=Post.find(post_id)
      post.vote_count=post.vote_count+1
      post.save
        "Successfully voted!"
    end
  end
end
