require 'integration_test_helper'

class CreateNewPostTest < ActionController::IntegrationTest
  fixtures :all

  test "the truth" do
    assert true
  end

  test "User should login to create post"  do
    visit "/posts"
    click_link "New Post"
    assert page.has_content?('Please log in')
    fill_in("Username:", :with=>users(:Sindhra).username)
    fill_in("Password:", :with=>"abcdef" )
    click_button "Log in"
    assert page.has_content?("Welcome #{users(:Sindhra).username}!")
 end


test "create new post" do
    visit "/log_in"
    fill_in "Username:", :with=>users(:Sindhra).username
    fill_in "Password:", :with=>"abcdef"
    click_button "Login"
    assert page.has_content?("Welcome #{users(:Sindhra).username}")
    click_link "New Post"
    fill_in "title", :with=>"This is new post"
    click_link "Create Post"
    assert page.has_content?("This is new post")
end

  test "search for posts" do
    visit "/posts"
    fill_in "search_input", :with=> "This is new post"

    click_button "post"
    assert page.has_content? ("This is new post")
  end

  test "search for users" do
    visit "/posts"
    fill_in "search_input", :with=> "Sindhra"

    click_button "user"
    assert page.has_content? ("Sindhra")
  end

end
