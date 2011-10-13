require 'test_helper'

class RepliesUsersControllerTest < ActionController::TestCase

  fixtures "replies"
  fixtures "replies_users"

   test "the truth" do
     assert true
   end

  test "User should not be able to vote their own reply" do
    session[:user_id] = replies(:reply1).user_id
    get :new, :id=>replies(:reply1).id
    assert_redirected_to :controller=>:replies, :action=>:index
  end
end
