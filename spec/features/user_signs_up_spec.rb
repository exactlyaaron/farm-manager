feature "Users signs up" do
  scenario "Happy Path, Sign Up and subsequent Sign In" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "aaron@example.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    click_button "Create My Account"
    expect(current_path).to eq dashboard_path
    page.should_not have_content("Sign Up")
    page.should_not have_content("Sign In")

    click_link "Sign Out"
    current_path.should == new_user_session_path

    fill_in "Email", with: "aaron@example.com"
    fill_in "Password", with: "password1"
    click_button "Log in"
    expect(page).to have_content("aaron@example.com")
  end

  scenario "with an email already in use" do
    visit '/'
    click_link "Sign Up"
    fill_in "Email", with: "aaron@example.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    click_button "Create My Account"

    click_link "Sign Out"
    expect(current_path).to eq(new_user_session_path)

    click_link "Sign Up"
    fill_in "Email", with: "aaron@example.com"
    fill_in "Password", with: "password1"
    click_button "Create My Account"
    expect(page).to have_content("has already been taken")
  end

  scenario "Skipped email and password" do
    visit '/'
    click_link "Sign Up"
    click_button "Create My Account"
    expect(page).to have_content("Your account could not be created.")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end