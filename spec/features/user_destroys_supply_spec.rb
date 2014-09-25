feature "Destroying a supply" do

  background do
    @user = Fabricate(:user)
    login_as @user
  end

  scenario "with one existing chemical" do
    Fabricate(:supply, user: @user, kind: "chemical")
    visit "/dashboard"
    click_on "My Supplies"
    click_on "Chemicals"
    first('ul.entry > li > a').click
    expect(page).to have_content("CHEMICALS")
    expect(Supply.count).to eq 0
    expect(page).to have_content("You have not yet purchased any chemicals")
    expect(page).to have_content("Add Your First Purchase")
  end


end