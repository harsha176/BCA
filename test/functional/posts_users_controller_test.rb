require 'test_helper'

class PostsUsersControllerTest < ActionController::TestCase
  fixtures "posts"
  fixtures "posts_users"

    test "the truth" do
     assert true
   end

  test "User should not be able to vote their own post" do
    session[:user_id] = posts(:post1).user_id
    get :new, :id=>posts(:post1).id
    assert_redirected_to :controller=>:posts, :action=>:index
  end
end
