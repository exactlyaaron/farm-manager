feature "Showing current supplies" do
  scenario "- new user with no supplies" do
    pending "implementation"
    visit "/"
    click_on "Supplies"
    expect(page).to have_content("You currently have not purchased any supplies")
    expect(page).to have_content("Total Cost: $0.00")
  end

  scenario "- with multiple chemicals" do
    pending "implementation"
    fabricate
  end

  scenario "- with multiple chemicals, fertilizers, and seeds" do
    pending "implementation"
    fabricate
    fabricate
    fabricate
  end
end