feature "Users signs in" do

  background do
    @user = Fabricate(:user)
    visit "/"
    click_link "Sign in"
  end

  scenario "with correct credentials" do
    fill_in "Email", with: "#{@user.email}"
    fill_in "Password", with: "#{@user.password}"
    click_button "Log in"
    expect(page).to have_content("Welcome back, #{@user.email}!")
  end

  scenario "with incorrect credentials" do
    fill_in "Email", with: "#{@user.email}"
    fill_in "Password", with: "wrong123"
    click_button "Log in"
    expect(page).to have_content("Invalid email or password.")
  end

  scenario "with an email that hasn't been registered" do
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password!"
    click_button "Log in"
    expect(page).to have_content("Invalid email address or password.")
    expect(find_field('Email').value).to include("joe@example.com")
    expect(find_field('Password').value).to be_blank
  end

  scenario "with the incorrect password" do
    fill_in "Email", with: "#{@user.email}"
    fill_in "Password", with: "notmypassword1!"
    click_button "Log in"
    expect(page).to have_content("Invalid email or password.")
    expect(find_field('Email').value).to include("#{@user.email}")
    expect(find_field('Password').value).to be_blank
  end

  scenario "with blank form" do
    click_button "Log in"
    expect(page).to have_content("Invalid email or password.")
  end

  scenario "Sign In with Facebook" do
    sign_into_facebook_as "joe"
    visit '/'
    click_link "Sign in with Facebook"
    expect(page).to have_content "Successfully authenticated from Facebook account."
    expect(page).to have_content "Sign Out"
    expect(page).not_to have_content "Sign Up"
    expect(page).not_to have_content "Sign In"
    click_link "Sign Out"
    expect(page).not_to have_content "Sign Out"
    expect(page).to have_content "Sign in with Facebook"
    expect(User.count).to eq 2
  end

  scenario "Login and Log out with Facebook" do
    Fabricate(:user,
      uid: "12345",
      email: "joe@example.com",
      name: "joe")
    sign_into_facebook_as "joe"
    visit '/'
    click_link "Sign in with Facebook"
    expect(page).to have_content "Successfully authenticated from Facebook account."

    expect(page).to have_content "Sign Out"
    expect(page).not_to have_content "Sign Up"
    expect(page).not_to have_content "Sign In"
    click_link "Sign Out"
    expect(page).not_to have_content "Sign Out"
    expect(page).to have_content "Sign in with Facebook"
    expect(User.count).to eq 3
  end

  scenario "then signs out" do
    fill_in "Email", with: "#{@user.email}"
    fill_in "Password", with: "#{@user.password}"
    click_button "Log in"
    click_link "Sign Out"
    expect(page).to have_content("Signed out successfully")
    expect(page).to have_content("Sign in")
  end
end