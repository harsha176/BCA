require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  fixtures "users"

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {:username=>"Sindhoora", :password=>"abcdef"}
    end

    assert_redirected_to :controller => :posts, :action=> :index
    
  end

  test "should show user" do
    get :show, id: @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user.to_param
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user.to_param, user: {:username=>"Sindhoora", :password=>"abcdef"}
    assert_redirected_to :controller => :users, :action=> :index
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.to_param
    end

    assert_redirected_to :controller => :users, :action=> :index
  end
end
