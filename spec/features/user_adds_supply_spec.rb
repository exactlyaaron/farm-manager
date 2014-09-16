feature "Adding a supply" do

  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "- new user with no supplies" do
    visit "/"
    click_on "Manage My Supplies"
    expect(page).to have_content("Chemicals")
    expect(page).to have_content("Fertilizer")
    expect(page).to have_content("Seed")
    expect(page).to have_content("Other")
    expect(page).to have_content("You currently have not purchased any supplies")
    expect(page).to have_content("Total Cost: $0.00")
  end

  scenario "- with one existing chemical" do
    Fabricate(:supply, user: @user, kind: "Chemical")
    visit "/"
    click_on "Manage My Supplies"
    expect(page).not_to have_content("You currently have not purchased any supplies")
    expect(page).to have_content("Total Cost: $10.00")
  end

  scenario "- with multiple existing supplies" do
    Fabricate(:supply, user: @user, kind: "Chemical")
    Fabricate(:supply, user: @user, kind: "Chemical")
    Fabricate(:supply, user: @user, kind: "Fertilizer")
    Fabricate(:supply, user: @user, kind: "Seed")
    Fabricate(:supply, user: @user, kind: "Other")
    visit "/"
    click_on "Manage My Supplies"
    expect(page).not_to have_content("You currently have not purchased any supplies")
    expect(page).to have_content("$20.00")
    expect(page).to have_content("$10.00")
    expect(page).to have_content("Total Cost: $50.00")
  end

  scenario "Happy Path from supplies index" do
    visit "/"
    click_on "Manage My Supplies"
    click_on "Add Purchase"
    select "2014", from: "supply_date_1i"
    select "March", from: "supply_date_2i"
    select "13", from: "supply_date_3i"
    fill_in "Name", with: "Round Up"
    fill_in "Vendor", with: "Fandrich's"
    select "qt", from: "Measure"
    fill_in "Price", with: "$400.00"
    click_on "Add Purchase"
    expect(page).to have_content("Round Up purchase has been added to your supplies")
    expect(Supply.count).to eq 1
    expect(page).to have_content("400")
    expect(current_path).to eq supplies_path
  end

  scenario "skipping filling out the form" do
    visit "/"
    click_on "Manage My Supplies"
    click_on "Add Purchase"
    click_on "Add Purchase"
    expect(page).to have_content("Purcahse could not be added.")
    expect(page).to have_error("must be selected", on: "Date")
    expect(page).to have_error("can't be blank", on: "Name")
    expect(page).to have_error("can't be blank", on: "Vendor")
    expect(page).to have_error("must be selected", on: "Measure")
    expect(page).to have_error("can't be blank", on: "Price")
  end

  scenario "from the chemicals index page" do
    visit "/"
    click_on "Manage My Supplies"
    click_on "Chemicals"
    click_on "Add Purchase"
    select "2014", from: "supply_date_1i"
    select "March", from: "supply_date_2i"
    select "13", from: "supply_date_3i"
    fill_in "Name", with: "Round Up"
    fill_in "Vendor", with: "Fandrich's"
    select "oz", from: "purcahse_measure"
    fill_in "Price", with: "$400.00"
    click_on "Add Purchase"
    expect(Supply.count).to eq 1
    expect(page).to have_content("Round Up purchase has been added to your supplies")
    expect(page).to have_content("400")
    expect(current_path).to eq chemicals_path
  end
end