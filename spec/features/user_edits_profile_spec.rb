feature "Users edits profile" do

  background do
    @user = Fabricate(:user)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: "#{@user.email}"
    fill_in "Password", with: "#{@user.password}"
    click_button "Log in"
  end

  scenario "updates name" do
    click_on "Account"
    click_on "Profile"
    fill_in "Name", with: "New Name"
    fill_in "Current password", with: "#{@user.password}"
    click_button "Update"
    expect(current_path).to eq dashboard_path
    expect(page).to have_content "account was updated"
    expect(page).to have_content "New Name"
  end

  scenario "updates budget" do
    click_on "Account"
    click_on "Profile"
    fill_in "Budget", with: "250"
    fill_in "Name", with: "New Name"
    fill_in "Current password", with: "#{@user.password}"
    click_button "Update"
    expect(current_path).to eq dashboard_path
    expect(page).to have_content "account was updated"
    expect(page).to have_content "$250.00"
  end

end