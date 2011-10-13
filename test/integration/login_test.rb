class LoginTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "login" do
    # login via https
    visit "/log_in"
    fill_in("Username:", :with=>users(:Sindhra).username)
    fill_in("Password:", :with=>"abcdef")
    click_button "Login"
    assert page.has_content?("Welcome #{users(:Sindhra).username}!")
  end
end