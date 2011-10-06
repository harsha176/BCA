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
    assert page.has_content?("Welcome #{users(:Sindhra).username}")
 end


test "create new post" do
    visit "/log_in"
    fill_in("Username:", :with=>users(:Sindhra).username)
    fill_in("Password:", :with=>"abcdef")
    click_button "Login"
    assert page.has_content?("Welcome #{users(:Sindhra).username}")
    click_link "New Post"
end

end