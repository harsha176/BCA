class PostsUsersController < ApplicationController
  def get_vote_count
      PostsUsers.get_vote_count(params[:post_id])
  end

  def vote
    PostsUsers.vote(params[:user_id], params[:post_id])
  end
end
