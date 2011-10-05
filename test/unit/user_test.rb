require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :user
  test "the truth" do
    assert true
  end

test "Username should be unique" do
  user = User.new
   user.username = User(:Sindhoora).username
   user.password = "check_password"
   user.id = (Users(:Sindhoora).id + 1)
   assert !user.valid?
   assert_equal("Username is not available", user.errors.on(:username))
 end

test "Password should be of minimum 6 characters" do
  user = User.new
   user.username = User(:Sindhra).username
   user.clear_text_password = "abcde"
  # assert
   assert_equal("Password should be more than 6 characters", user.errors.on(:username))
end


test "Authenticate user"  do
  user = User.new
   user.username = "Sindu"
   user.clear_text_password = "sindhoora"
   user.save
   assert User.authenticate(user.username, user.encrypt_password)
 end
end