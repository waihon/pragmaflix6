require "rails_helper"

describe "Creating a new movie" do
  it "saves the movie and shows the new movie's details" do
    visit movies_url

    click_link "Add New Movie"

    expect(current_path).to eq(new_movie_path)

    fill_in "Title", with: "New Movie Title"
    fill_in "Description", with: "Superheroes saving the world from villains"
    select "PG-13", from: "movie_rating"
    select (Time.now.year - 1).to_s, from: "movie_released_on_1i"
    select "September", from: "movie_released_on_2i"
    select "18", from: "movie_released_on_3i"
    fill_in "Total gross", with: "75000000"
    fill_in "Director", with: "The ever-creator director"
    fill_in "Duration", with: "168 min"
    fill_in "Image file name", with: "ironman.png"

    click_button "Create Movie"

    expect(current_path).to eq(movie_path(Movie.last))
    expect(page).to have_text("New Movie Title")
    expect(page).to have_text("Movie successfully created!")
  end

  it "does not save the movie if it's invalid" do
    visit new_movie_url

    expect {
      click_button "Create Movie"
    }.not_to change(Movie, :count)

    # Create Movie -> POST /movies
    expect(current_path).to eq(movies_path)

    expect(page).to have_text("errors")
    expect(page).to have_text("Title can't be blank")
    expect(page).to have_text("Duration can't be blank")
    expect(page).to have_text("Description is too short (minimum is 25 characters)")
    expect(page).to have_text("Total gross is not a number")
    expect(page).to have_text("Rating is not included in the list")
  end
end
