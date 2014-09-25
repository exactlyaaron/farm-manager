feature "Editing a field" do

  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "from the fields index page" do
    @field = Fabricate(:field, user: @user)
    visit "/dashboard"
    click_on "My Fields"
    click_on "Edit"
    fill_in "Name", with: "New Field Name"
    fill_in "Acreage", with: "45"
    fill_in "Crop", with: "New Crop"
    click_on "Update Field"
    expect(Field.count).to eq 1
    expect(Field.first.name).to eq "New Field Name"
    expect(Field.first.acreage).to eq 45
    expect(page).to have_content("New Field Name")
    expect(page).to have_content("45")
    expect(page).to have_content("New Crop")
  end

  scenario "from the field show page" do
    @field = Fabricate(:field, user: @user)
    visit "/dashboard"
    click_on "My Fields"
    first('ul.fields-entry > li > a').click
    click_on "Edit"
    fill_in "Name", with: "Last Field"
    fill_in "Acreage", with: "45"
    fill_in "Crop", with: "New Crop"
    fill_in "Notes", with: "Notes here"
    click_on "Update Field"
    expect(Field.count).to eq 1
    expect(Field.last.name).to eq "Last Field"
    expect(Field.last.acreage).to eq 45
    expect(page).to have_content("Last Field")
    expect(page).to have_content("45")
    expect(page).to have_content("New Crop")
    expect(page).to have_content("Notes here")
  end


end