feature "Users signs in" do

  before do
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
end