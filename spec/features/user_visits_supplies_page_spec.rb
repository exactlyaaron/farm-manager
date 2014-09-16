feature "Showing current supplies" do
  scenario "- new user with no supplies" do
    visit "/"
    click_on "Supplies"
    expect(page).to have_content("You currently have not purchased any supplies")
    expect(page).to have_content("Total Cost: $0.00")
  end
end