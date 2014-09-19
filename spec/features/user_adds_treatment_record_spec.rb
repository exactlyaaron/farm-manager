feature "Adding a treatment to a field" do

  background do
    @user = Fabricate(:user)
    @supply1 = Fabricate(:supply, user: @user, kind:"chemical", name: "Round Up")
    @supply2 = Fabricate(:supply, user: @user, kind:"chemical", name: "Atrazine")
    @supply3 = Fabricate(:supply, user: @user, kind:"chemical", name: "Surfactant")
    @field = Fabricate(:field, user: @user)
    login_as @user
  end

  scenario "- new field with no treatments" do
    visit "/dashboard"
    click_on "Manage My Fields"
    first('ul.fields-entry > li > a').click
    expect(page).to have_content("You currenty have no treatment records for your field.")
    expect(page).to have_content("Add your first entry")
    click_on "Add your first entry"
    select "Surfactant", from: "Supply"
    select "2014", from: "treatment_date_1i"
    select "March", from: "treatment_date_2i"
    select "13", from: "treatment_date_3i"
    fill_in "Total Applied", with: "450"
    click_on "Save Treatment"
    expect(page).to have_content("Surfactant")
    expect(page).to have_content("2014-03-13")
    expect(page).to have_content("oz")
    expect(page).to have_content("0.40")
    expect(page).to have_content("450")
    expect(page).to have_content("18")
    expect(page).to have_content("7.20")
    expect(page).to have_content("180")
  end

  scenario "- field with existing treatments" do
    Fabricate(:treatment, field: @field, supply: @supply1, quantity: 10)
    Fabricate(:treatment, field: @field, supply: @supply2, quantity: 10)
    visit "/dashboard"
    click_on "Manage My Fields"
    first('ul.fields-entry > li > a').click
    expect(page).not_to have_content("You currenty have no treatment records for your field.")
    expect(page).not_to have_content("Add your first entry")
    click_on "Add entry"
    select "Surfactant", from: "Supply"
    select "2014", from: "treatment_date_1i"
    select "March", from: "treatment_date_2i"
    select "13", from: "treatment_date_3i"
    fill_in "Total Applied", with: "450"
    click_on "Save Treatment"
    expect(page).to have_content("Surfactant")
    expect(page).to have_content("2014-03-13")
    expect(page).to have_content("oz")
    expect(page).to have_content("0.40")
    expect(page).to have_content("450")
    expect(page).to have_content("18")
    expect(page).to have_content("7.20")
    expect(page).to have_content("180")
    # save_and_open_page
    expect(page).to have_content("Round Up")
    expect(page).to have_content("Atrazine")
    expect(page).to have_content("10")
    expect(page).to have_content("0.4")
    expect(page).to have_content("188")
  end

end