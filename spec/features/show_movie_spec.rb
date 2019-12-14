require "rails_helper"

describe "Viewing an individual movie" do
  it "shows the movie's details" do
    movie = Movie.create(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_css("img[src*='ironman'][src$='.png']")
    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.released_on.year)
    expect(page).to have_text(movie.rating)

    expect(page).to have_text(movie.description)

    expect(page).to have_text(movie.director)
    expect(page).to have_text(movie.duration)
  end

  context "total gross exceeds $50M" do
    before(:example) do
      @movie = Movie.create(movie_attributes(total_gross: 50_000_000_000.00))
    end

    it "shows the total gross" do
      visit movie_url(@movie)

      expect(page).to have_text("$50,000,000")
    end
  end

  context "total gross is less than $50M" do
    before(:example) do
      @movie = Movie.create(movie_attributes(total_gross: 49_999_999.99))
    end

    it "shows 'Flop!' instead of total gross" do
      visit movie_url(@movie)

      expect(page).to have_text("Flop!")
      expect(page).not_to have_text("$49,999,999")
      expect(page).not_to have_text("$49,999,999.99")
    end
  end

  context "no reviews" do
    before(:example) do
      @movie = Movie.create(movie_attributes)
    end

    it "shows 0 front stars" do
      visit movie_url(@movie)

      expect(page).to have_css("div.back-stars")
      expect(page).to have_css("div.front-stars[style='width: 0.0%']", text: "★ ★ ★ ★ ★")
    end

    it "shows '0 Reviews'" do
      visit movie_url(@movie)

      expect(page).to have_text("0 Reviews")
    end
  end

  context "one or more reviews" do
    before(:example) do
      @movie = Movie.create(movie_attributes)

      @movie.reviews.create(review_attributes(stars:1))
      @movie.reviews.create(review_attributes(stars:3))
      @movie.reviews.create(review_attributes(stars:5))
    end

    it "shows the average number of front stars" do
      visit movie_url(@movie)

      expect(page).to have_css("div.back-stars")
      expect(page).to have_css("div.front-stars[style='width: 60.0%']", text: "★ ★ ★ ★ ★")
    end

    it "shows the number of reviews posted" do
      visit movie_url(@movie)

      expect(page).to have_text("3 Reviews")
    end
  end
end
