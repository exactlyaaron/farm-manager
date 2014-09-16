feature "Adding a supply" do
  scenario "Happy Path from supplies index" do
    pending "implementation"
    visit '/'
    click_on "Manage My Supplies"
    click_on "Add Purchase"
    select "2014", from: "purchase_date_1i"
    select "March", from: "purchase_date_2i"
    select "13", from: "purchase_date_3i"
    fill_in "Name", with: "Round Up"
    fill_in "Vendor", with: "Fandrich's"
    select "oz", from: "purcahse_measure"
    fill_in "Price", with: "$400.00"
    click_on "Add Purchase"
    expect(page).to have_content("Round Up purchase has been added to your supplies")
    expect(current_path).to eq supplies_path
  end

  scenario "skipping filling out the form" do
    pending "implementation"
    visit '/'
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
    pending "implementation"
    visit '/'
    click_on "Supplies"
    click_on "Chemicals"
    click_on "Add Purchase"
    select "2014", from: "purchase_date_1i"
    select "March", from: "purchase_date_2i"
    select "13", from: "purchase_date_3i"
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