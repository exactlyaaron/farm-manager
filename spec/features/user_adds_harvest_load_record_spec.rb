feature "Adding a harvest load record for a field" do

  background do
    @user = Fabricate(:user)
    @supply1 = Fabricate(:supply, user: @user, kind:"chemical", name: "Round Up")
    @supply2 = Fabricate(:supply, user: @user, kind:"chemical", name: "Atrazine")
    @supply3 = Fabricate(:supply, user: @user, kind:"chemical", name: "Surfactant")
    @field = Fabricate(:field, user: @user)
    login_as @user
  end

  scenario "- new field with no harvest loads" do
    visit "/dashboard"
    click_on "My Fields"
    first('ul.fields-entry > li > a').click
    expect(page).to have_content("You currenty have no harvest records for your field.")
    expect(page).to have_content("Add your first load")
    click_on "Add your first load"
    fill_in "Receipt number", with: "0001"
    fill_in "Price per bushel", with: "1.50"
    fill_in "Bushels sold", with: "25"
    select "2014", from: "harvest_load_date_1i"
    select "March", from: "harvest_load_date_2i"
    select "13", from: "harvest_load_date_3i"
    click_on "Save Load"
    expect(page).not_to have_content("You currenty have no harvest records for your field.")
    expect(page).to have_content("Harvest record has been added to your field.")
    expect(page).to have_content("Receipt Number")
    expect(page).to have_content("Price Per Bushel")
    expect(page).to have_content("Bushels Sold")
    expect(page).to have_content("Income")
    expect(page).to have_content("0001")
    expect(page).to have_content("1.50")
    expect(page).to have_content("25")
    expect(page).to have_content("37.50")
    expect(page).to have_content("Grand Total")
  end

  scenario "- field with previous harvest loads" do
    Fabricate(:harvest_load, field: @field)
    Fabricate(:harvest_load, field: @field)
    visit "/dashboard"
    click_on "My Fields"
    first('ul.fields-entry > li > a').click
    expect(page).not_to have_content("You currenty have no harvest records for your field.")
    expect(page).not_to have_content("Add your first load")
    click_on "Add Harvest Load"
    fill_in "Receipt number", with: "2222"
    fill_in "Price per bushel", with: "1.50"
    fill_in "Bushels sold", with: "25"
    select "2014", from: "harvest_load_date_1i"
    select "March", from: "harvest_load_date_2i"
    select "13", from: "harvest_load_date_3i"
    click_on "Save Load"
    expect(page).to have_content("Harvest record has been added to your field.")
    expect(page).to have_content("Receipt Number")
    expect(page).to have_content("Price Per Bushel")
    expect(page).to have_content("Bushels Sold")
    expect(page).to have_content("Income")
    expect(page).to have_content("0")
    expect(page).to have_content("1")
    expect(page).to have_content("2222")
    expect(page).to have_content("1.50")
    expect(page).to have_content("25")
    expect(page).to have_content("37.50")
    expect(page).to have_content("Grand Total")
    expect(page).to have_content("57.50")
  end

end