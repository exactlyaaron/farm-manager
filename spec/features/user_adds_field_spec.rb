feature "Adding a supply" do

  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "- new user with no fields" do
    visit "/dashboard"
    click_on "Manage My Fields"
    expect(page).to have_content("Add New Field")
    expect(page).to have_content("0 acres")
    expect(page).to have_content("You currently don't have any fields.")
  end

  scenario "- with existing fields " do
    Fabricate(:field, user: @user)
    Fabricate(:field, user: @user)
    Fabricate(:field, user: @user)
    visit "/dashboard"
    click_on "Manage My Fields"
    expect(page).not_to have_content("You currently don't have any fields.")
    expect(page).to have_content("75 acres")
  end

  scenario "Happy Path from fields index" do
    visit "/dashboard"
    click_on "Manage My Fields"
    click_on "Add New Field"
    fill_in "Name", with: "Sample Field 1"
    fill_in "Acreage", with: "40"
    fill_in "Crop", with: "Corn"
    fill_in "Notes", with: "This is my first corn field"
    click_on "Save Field"
    expect(page).to have_content("Sample Field 1 has been added to your fields")
    expect(Field.count).to eq 1
    expect(page).to have_content("40")
    expect(page).to have_content("Corn")
  end

  scenario "skipping filling out the form" do
    visit "/dashboard"
    click_on "Manage My Fields"
    click_on "Add New Field"
    click_on "Save Field"
    expect(current_path).to eq new_field_path
  end

end