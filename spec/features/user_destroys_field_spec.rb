feature "Destroying a supply" do

  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "with one existing field" do
    Fabricate(:field, user: @user)
    visit "/dashboard"
    click_on "Manage My Fields"
    click_on "Delete"
    expect(page).to have_content("Fields")
    expect(Field.count).to eq 0
    expect(page).to have_content("You currently don't have any fields.")
    expect(page).to have_content("Add your first field")
  end


end