feature "Adding a field" do

  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "- new user with no fields" do
    visit "/dashboard"
    click_on "My Fields"
    expect(page).to have_content("Add New Field")
    expect(page).to have_content("0 acres")
    expect(page).to have_content("You currently don't have any fields.")
  end

  scenario "- with existing fields " do
    Fabricate(:field, user: @user)
    Fabricate(:field, user: @user)
    Fabricate(:field, user: @user)
    visit "/dashboard"
    click_on "My Fields"
    expect(page).not_to have_content("You currently don't have any fields.")
    expect(page).to have_content("75 acres")
  end

  scenario "Happy Path from fields index" do
    visit "/dashboard"
    click_on "My Fields"
    click_on "Add New Field"
    fill_in "Name", with: "Sample Field 1"
    fill_in "Acreage", with: "40"
    select "Corn", from: "Crop"
    fill_in "Notes", with: "This is my first corn field"
    click_on "Save Field"
    expect(page).to have_content("Sample Field 1 has been added to your fields")
    expect(Field.count).to eq 1
    expect(page).to have_content("40")
    expect(page).to have_content("Corn")
  end

  scenario "skipping filling out the form" do
    visit "/dashboard"
    click_on "My Fields"
    click_on "Add New Field"
    click_on "Save Field"
    expect(current_path).to eq new_field_path
  end

  scenario "- viewing the basic field details" do
    Fabricate(:field, user: @user)
    visit "/dashboard"
    click_on "My Fields"
    first('ul.fields-entry > li > a').click
    expect(page).to have_content("MY FIELD")
    expect(page).to have_content("notes about the field")
    expect(page).to have_content("Total Field Cost")
  end

end