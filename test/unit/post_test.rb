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

  test "Every post must have a title" do
  post = Post.new
  assert !post.valid?
end

end
