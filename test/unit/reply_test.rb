require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :replies
   test "the truth" do
    assert true
  end


 test "Every reply must have a message" do
   reply = Reply.new
   assert !reply.valid?
 end

end
