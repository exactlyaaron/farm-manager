feature "Destroying a supply" do

  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "with one existing chemical" do
    @supply = Fabricate(:supply, user: @user, kind: "chemical")
    visit "/dashboard"
    click_on "Manage My Supplies"
    click_on "Chemicals"
    click_on "Edit"
    select "2014", from: "supply_purchase_date_1i"
    select "March", from: "supply_purchase_date_2i"
    select "13", from: "supply_purchase_date_3i"
    fill_in "Name", with: "New Chemical Name"
    fill_in "Vendor", with: "New Vendor"
    select "bag", from: "Measure"
    fill_in "Price", with: "200.00"
    click_on "Update Purchase"
    expect(page).to have_content("Chemicals")
    expect(Supply.count).to eq 1
    expect(page).to have_content("New Chemical Name")
    expect(page).to have_content("New Vendor")
    expect(page).to have_content("2014-03-13")
  end


end