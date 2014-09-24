feature "Adding a supply" do

  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "- new user with no supplies" do
    visit "/dashboard"
    click_on "My Supplies"
    expect(page).to have_content("Chemicals")
    expect(page).to have_content("Fertilizer")
    expect(page).to have_content("Seed")
    expect(page).to have_content("Other")
    expect(page).to have_content("You currently have not purchased any supplies")
    expect(page).to have_content("Total Cost: $0.00")
  end

  scenario "- with one existing chemical" do
    Fabricate(:supply, user: @user, kind: "chemical")
    visit "/dashboard"
    click_on "My Supplies"
    expect(page).not_to have_content("You currently have not purchased any supplies")
    expect(page).to have_content("Total Cost: $10.00")
  end

  scenario "- with multiple existing supplies" do
    Fabricate(:supply, user: @user, kind: "chemical")
    Fabricate(:supply, user: @user, kind: "chemical")
    Fabricate(:supply, user: @user, kind: "fertilizer")
    Fabricate(:supply, user: @user, kind: "seed")
    Fabricate(:supply, user: @user, kind: "other")
    visit "/dashboard"
    click_on "My Supplies"
    expect(page).not_to have_content("You currently have not purchased any supplies")
    expect(page).to have_content("$20.00")
    expect(page).to have_content("$10.00")
    expect(page).to have_content("Total Cost: $50.00")
  end

  scenario "Happy Path from supplies index" do
    visit "/dashboard"
    click_on "My Supplies"
    click_on "Add Purchase"
    select "chemical", from: "Kind"
    select "2014", from: "supply_purchase_date_1i"
    select "March", from: "supply_purchase_date_2i"
    select "13", from: "supply_purchase_date_3i"
    fill_in "Name", with: "Round Up"
    fill_in "Vendor", with: "Fandrich's"
    select "qt", from: "Measure"
    fill_in "Quantity", with: "240"
    fill_in "Price", with: "400.00"
    click_on "Add Purchase"
    expect(page).to have_content("Round Up purchase has been added to your supplies")
    expect(Supply.count).to eq 1
    expect(Supply.first.unit_cost).to eq 1.67
    expect(page).to have_content("400")
    expect(current_path).to eq '/supplies/chemical'
  end

  scenario "from the chemicals page" do
    visit "/dashboard"
    click_on "My Supplies"
    click_on "Chemicals"
    click_on "Add Purchase"
    select "chemical", from: "Kind"
    select "2014", from: "supply_purchase_date_1i"
    select "March", from: "supply_purchase_date_2i"
    select "13", from: "supply_purchase_date_3i"
    fill_in "Name", with: "Round Up"
    fill_in "Vendor", with: "Fandrich's"
    select "oz", from: "Measure"
    fill_in "Quantity", with: "240"
    fill_in "Price", with: "400.23"
    click_on "Add Purchase"
    expect(Supply.count).to eq 1
    expect(current_path).to eq '/supplies/chemical'
    expect(page).to have_content("Round Up purchase has been added to your supplies")
    expect(page).to have_content("400")
  end

  scenario "from the fertilizer page" do
    visit "/dashboard"
    click_on "My Supplies"
    click_on "Fertilizer"
    click_on "Add Purchase"
    select "fertilizer", from: "Kind"
    select "2014", from: "supply_purchase_date_1i"
    select "March", from: "supply_purchase_date_2i"
    select "13", from: "supply_purchase_date_3i"
    fill_in "Name", with: "SuperFertilizer"
    fill_in "Vendor", with: "Fandrich's"
    select "oz", from: "Measure"
    fill_in "Quantity", with: "240"
    fill_in "Price", with: "200.00"
    click_on "Add Purchase"
    expect(Supply.count).to eq 1
    expect(current_path).to eq '/supplies/fertilizer'
    expect(page).to have_content("SuperFertilizer purchase has been added to your supplies")
    expect(page).to have_content("200")
  end

  scenario "from the seed page" do
    visit "/dashboard"
    click_on "My Supplies"
    click_on "Seed"
    click_on "Add Purchase"
    select "seed", from: "Kind"
    select "2014", from: "supply_purchase_date_1i"
    select "March", from: "supply_purchase_date_2i"
    select "13", from: "supply_purchase_date_3i"
    fill_in "Name", with: "SuperFertilizer"
    fill_in "Vendor", with: "Fandrich's"
    fill_in "Quantity", with: "240"
    select "bag", from: "Measure"
    fill_in "Price", with: "200.12"
    click_on "Add Purchase"
    expect(Supply.count).to eq 1
    expect(current_path).to eq '/supplies/seed'
    expect(page).to have_content("SuperFertilizer purchase has been added to your supplies")
    expect(page).to have_content("200.12")
  end

  scenario "skipping filling out the form" do
    visit "/dashboard"
    click_on "My Supplies"
    click_on "Add Purchase"
    click_on "Add Purchase"
    expect(current_path).to eq new_supply_path
  end
end