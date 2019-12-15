require "rails_helper"

describe "Navigating reviews" do
  it "allows navigation from the movie detail page to reviews listing page" do
    movie = Movie.create(movie_attributes)
    review = movie.reviews.create(review_attributes)

    visit movie_url(movie)
    click_link "1 Review"

    expect(current_path).to eq(movie_reviews_path(movie))
    expect(page).to have_text(movie.title)
  end

  it "allows navigation from the reviews listing page to movie detail page" do
    movie = Movie.create(movie_attributes)
    review = movie.reviews.create(review_attributes)

    visit movie_reviews_url(movie)
    click_link movie.title

    expect(current_path).to eq(movie_path(movie))
    expect(page).to have_text(movie.title )
  end
end
