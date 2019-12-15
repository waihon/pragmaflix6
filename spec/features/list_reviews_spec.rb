require "rails_helper"

describe "Viewing a list of reviews" do
  it "shows the reviews posted for a specific movie" do
    movie1 = Movie.create(movie_attributes(title: "Iron Man"))
    review1 = movie1.reviews.create(review_attributes(name: "Roger Ebert", comment: "Awesome!", stars: 4))
    review2 = movie1.reviews.create(review_attributes(name: "Gene Siskel", comment: "Bravo!", stars: 5))

    movie2 = Movie.create(movie_attributes(title: "Superman"))
    review3 = movie2.reviews.create(review_attributes(name: "Peter Travers", comment: "Cheers!", stars: 3))

    visit movie_reviews_url(movie1)

    expect(page).to have_text(movie1.title)
    expect(page).to have_css("div.back-stars")

    expect(page).to have_text(review1.name)
    expect(page).to have_text(review1.comment)
    expect(page).to have_css("div.front-stars[style='width: 80.0%']", text: "★ ★ ★ ★ ★")

    expect(page).to have_text(review2.name)
    expect(page).to have_text("less than a minute ago", count: 2)
    expect(page).to have_text(review2.comment)
    expect(page).to have_css("div.front-stars[style='width: 100.0%']", text: "★ ★ ★ ★ ★")

    expect(page).not_to have_text(review3.name)
    expect(page).not_to have_text(review3.comment)
    expect(page).not_to have_css("div.front-stars[style='width: 60.0%']", text: "★ ★ ★ ★ ★")
  end
end
