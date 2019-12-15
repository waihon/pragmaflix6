require "rails_helper"

describe "Deleting a movie" do
  it "destroys the movie and show the movies listing without the deleted movie" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)
    click_link "Delete"

    expect(current_path).to eq(movies_path)
    expect(page).not_to have_text(movie.title)
    expect(page).to have_text("Movie successfully deleted!")
  end
end
