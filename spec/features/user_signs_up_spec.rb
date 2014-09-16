feature "Users signs up" do
  background do
    visit '/'
    click_link "Sign Up"
  end

  scenario "Happy Path, Sign Up and subsequent Sign In" do
    fill_in "Email", with: "aaron@example.com"
    Capybara.exact = true
    fill_in "* Password", with: "password1"
    fill_in "* Password confirmation", with: "password1"
    Capybara.exact = false
    click_button "Create My Account"
    expect(current_path).to eq dashboard_path
    expect(page).not_to have_content("Sign Up")
    expect(page).not_to have_content("Sign In")
    expect(User.count).to eq 1

    click_link "Sign Out"
    current_path.should == new_user_session_path

    fill_in "Email", with: "aaron@example.com"
    fill_in "Password", with: "password1"
    click_button "Log in"
    expect(page).to have_content("aaron@example.com")
  end

  scenario "with an email already in use" do
    fill_in "Email", with: "aaron@example.com"
    Capybara.exact = true
    fill_in "* Password", with: "password1"
    fill_in "* Password confirmation", with: "password1"
    Capybara.exact = false
    click_button "Create My Account"

    click_link "Sign Out"
    expect(current_path).to eq(new_user_session_path)

    click_link "Sign Up"
    fill_in "Email", with: "aaron@example.com"
    Capybara.exact = true
    fill_in "* Password", with: "password1"
    fill_in "* Password confirmation", with: "password1"
    Capybara.exact = false
    click_button "Create My Account"
    expect(page).to have_content("has already been taken")
  end

  scenario "Skipped email and password" do
    click_button "Create My Account"
    expect(page).to have_content("can't be blank")
  end

  scenario "with empty input fields" do
    click_on "Create My Account"
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign in")
    expect(page).to have_content("can't be blank")
    expect(current_path).to eq(user_registration_path)
  end

  scenario "with invalid information" do
    fill_in "Email", with: "example@user.com"
    Capybara.exact = true
    fill_in "* Password", with: "aaaaaa"
    fill_in "* Password confirmation", with: "aaaaaa"
    Capybara.exact = false
    click_on "Create My Account"
    expect(page).to have_content("Please review the problems below:")
    expect(page).to have_content("is too short (minimum is 8 characters)")
    expect(current_path).to eq(user_registration_path)
  end

  scenario "with non-matching passwords" do
    fill_in "Email", with: "example@user.com"
    Capybara.exact = true
    fill_in "* Password", with: "aaaaaa"
    fill_in "* Password confirmation", with: "invalid11"
    Capybara.exact = false
    click_on "Create My Account"
    expect(page).to have_content("Please review the problems below:")
    expect(page).to have_content("doesn't match Password")
    expect(current_path).to eq(user_registration_path)
  end

end