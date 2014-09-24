feature "Editing a harvest load on a field" do

  background do
    @user = Fabricate(:user)
    @field = Fabricate(:field, user: @user)
    login_as @user
  end

  scenario "- with only one existing treatment" do
    Fabricate(:harvest_load, field: @field)
    visit "/dashboard"
    click_on "My Fields"
    first('ul.fields-entry > li > a').click
    within("ul.loads-entry") do
      click_on "Edit"
    end
    fill_in "Receipt number", with: "13"
    fill_in "Price per bushel", with: "2.50"
    fill_in "Bushels sold", with: "25"
    select "2014", from: "harvest_load_date_1i"
    select "March", from: "harvest_load_date_2i"
    select "13", from: "harvest_load_date_3i"
    click_on "Save Load"
    expect(page).not_to have_content("You currenty have no harvest records for your field.")
    expect(page).not_to have_content("Add your first load")
    expect(page).to have_content("Harvest record was updated successfully")
    expect(page).to have_content("13")
    expect(page).to have_content("2.50")
    expect(page).to have_content("25")
    expect(page).to have_content("2014-03-13")
    expect(HarvestLoad.count).to eq 1
    expect(HarvestLoad.first.receipt_number).to eq "13"
  end

end