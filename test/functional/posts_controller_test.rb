require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  fixtures "posts"
  fixtures "votes"

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    session[:user_id] = 1
    get :new
    assert_response :success

    session[:user_id] = nil
    get :new
    assert_redirected_to :controller=>:users, :action=>:login
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: @post.attributes
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post.to_param
    assert_response :success
  end

  test "should update post" do
    put :update, {id => @post.to_param, title => @post.title, message => @post.message}
    assert_redirected_to :controller => "posts", :action=> "index"
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.to_param
    end

    assert_redirected_to :controller => :posts, :action=> :index
  end
end
