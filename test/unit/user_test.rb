require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :users
  test "the truth" do
    assert true
  end

  test "Username cannot be empty"    do
    user = User.new
    assert !user.valid?
  end

  test "Password is required" do
    user = User.new
    user.username ='Sindu'
    user.password =''
    user.save
    assert !user.valid?
  end

  test "Username should be unique" do
    user = User.new
    user.username = users(:Sindhra).username
    user.password = "abcdef"
    user.id = (users(:Sindhra).id + 1)
    assert !user.valid?
    user.errors[:username]= ["Username is already taken"]

 end

test "Authenticate user"  do
  user = User.new
   user.username = "Sindu"
   user.password = "sindhoora"
   user.save
   assert User.authenticate(user.username, user.password)
 end
end