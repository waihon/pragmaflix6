require "rails_helper"

describe "Deleting a review" do
  it "destroys the review and show the reviews listing" do
    movie = Movie.create(movie_attributes)
    review1 = movie.reviews.create(review_attributes(name: "Roger Ebert", comment: "Awesome!", stars: 4))
    review2 = movie.reviews.create(review_attributes(name: "Gene Siskel", comment: "Bravo!", stars: 5))
    review3 = movie.reviews.create(review_attributes(name: "Peter Travers", comment: "Cheers!", stars: 3))

    visit movie_reviews_url(movie)
    find("#delete-review-#{review2.id}").click

    expect(current_path).to eq(movie_reviews_path(movie))
    expect(page).to have_text(review1.name)
    expect(page).not_to have_text(review2.name)
    expect(page).to have_text(review3.name)
    expect(page).to have_text("Review successfully deleted!")
  end
end
