require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :posts
   test "the truth" do
    assert true
  end


 test "Every post must have a message" do
   post = Post.new
   assert !post.valid?
 end

 test "A post belongs to only one user" do
   post = Post.new(:id => posts(:post).id,
                   :message => "To test if the post is unique for a user",
                   :user_id => posts(:post).User.id)
   assert post.save
 end
end
