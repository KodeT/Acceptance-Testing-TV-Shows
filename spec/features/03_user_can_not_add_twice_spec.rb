require 'spec_helper'

# As an organized TV fanatic
# I want to receive an error message if I try to add the same show twice
# So that I don't have duplicate entries

# Acceptance Criteria:
# [] If the title is the same as a show that I've already added, the details are not saved to the csv
# [] If the title is the same as a show that I've already added, I will be shown an error that says "The show has already been added".
# [] If the details of the show are not saved, I will remain on the new form page
feature "does not save duplicates" do

  scenario "#users does not put in a duplicate" do
    visit "/television_shows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "genre"
    click_button "Add TV Show"
    expect(page).to have_content "List of Shows"

    expect(page).to have_content "Friends (NBC)"

    visit "/television_shows/new"

    fill_in "Title", with: "House of Cards"
    fill_in "Network", with: "Netflix"
    fill_in "Starting Year", with: "2013"
    fill_in "Synopsis", with: "Man is a jerk"
    select "Drama", from: "genre"
    click_button "Add TV Show"
    expect(page).to have_content "List of Shows"

    expect(page).to have_content "House of Cards (Netflix)"
  end

  scenario "#user puts in a duplicate" do
    visit "/television_shows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "genre"
    click_button "Add TV Show"

    visit "/television_shows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "genre"
    click_button "Add TV Show"
    expect(page).to have_content "That show has already been added"

  end
end
