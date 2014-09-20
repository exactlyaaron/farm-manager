feature "Editing a treatment on a field" do

  background do
    @user = Fabricate(:user)
    @supply1 = Fabricate(:supply, user: @user, kind:"chemical", name: "Round Up")
    @supply2 = Fabricate(:supply, user: @user, kind:"chemical", name: "Atrazine")
    @supply3 = Fabricate(:supply, user: @user, kind:"chemical", name: "Surfactant")
    @field = Fabricate(:field, user: @user)
    login_as @user
  end

  scenario "- with only one existing treatment" do
    Fabricate(:treatment, field: @field, supply: @supply1, quantity: 10)
    visit "/dashboard"
    click_on "Manage My Fields"
    first('ul.fields-entry > li > a').click
    within("ul.treatments-entry") do
      click_on "Edit"
    end
    select "Atrazine", from: "Supply"
    select "2014", from: "treatment_date_1i"
    select "March", from: "treatment_date_2i"
    select "14", from: "treatment_date_3i"
    fill_in "Total Applied", with: "475"
    click_on "Save Treatment"
    expect(page).not_to have_content("You currenty have no treatment records for your field.")
    expect(page).not_to have_content("Add your first entry")
    expect(page).to have_content("Treatment record was updated successfully")
    expect(page).to have_content("Atrazine")
    expect(page).to have_content("2014-03-14")
    expect(page).to have_content("475")
    expect(Treatment.count).to eq 1
    expect(Treatment.first.supply.name).to eq "Atrazine"
  end

end