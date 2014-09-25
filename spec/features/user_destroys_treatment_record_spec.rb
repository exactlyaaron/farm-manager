feature "Destroying a treatment from a field" do

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
    visit "/fields"
    first('tr.fields-entry > td > a').click
    within("tr.treatments-entry") do
      click_on "Delete"
    end
    expect(page).to have_content("You currenty have no treatment records for your field.")
    expect(page).to have_content("Add your first entry")
    expect(Treatment.count).to eq 0
  end

end