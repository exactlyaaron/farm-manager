feature "Destroying a harvest load from a field" do

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
      click_on "Delete"
    end
    expect(page).to have_content("You currenty have no harvest records for your field.")
    expect(page).to have_content("Add your first load")
    expect(HarvestLoad.count).to eq 0
  end

end