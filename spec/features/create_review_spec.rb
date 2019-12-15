require "rails_helper"

describe "Creating a new review" do
  describe "via new review page" do
    it "saves the review" do
      movie = Movie.create(movie_attributes)
      visit movie_url(movie)
      expect(page).to have_text("0 Reviews")

      visit new_movie_review_url(movie)

      expect(current_path).to eq(new_movie_review_path(movie))

      fill_in "Name", with: "Roger Ebert"
      choose "review_stars_3" # 3 stars
      fill_in "Comment", with: "I laughed, I cried, I spilled my popcorn!"
      click_button "Post Review"

      expect(current_path).to eq(movie_reviews_path(movie))
      expect(page).to have_text("Thanks for your review!")
    end

    it "does not save the review if it's invalid" do
      movie = Movie.create(movie_attributes)

      visit new_movie_review_url(movie)

      expect {
        click_button "Post Review"
      }.not_to change(Review, :count)

      # Post Review -> POST movies/:movie_id/reviews
      expect(current_path).to eq(movie_reviews_path(movie))
      expect(page).to have_text("error")
      expect(page).to have_text("Name can't be blank")
      expect(page).to have_text("Stars must be between 1 and 5")
      expect(page).to have_text("Comment is too short (minimum is 4 characters)")
    end

    it "does not allow cancellation" do
      movie = Movie.create(movie_attributes)

      visit new_movie_review_url(movie)

      expect(page).not_to have_link("Cancel")
    end
  end

  describe "via movie show page" do
    it "saves the review" do
      movie = Movie.create(movie_attributes)
      visit movie_url(movie)
      expect(current_path).to eq(movie_path(movie))
      expect(page).to have_text("0 Reviews")
      expect(page).to have_text("Write Review")

      fill_in "Name", with: "Roger Ebert"
      choose "review_stars_5" # 5 stars
      fill_in "Comment", with: "I laughed, I cried, I spilled my popcorn!"
      click_button "Post Review"

      expect(current_path).to eq(movie_reviews_path(movie))
      expect(page).to have_text("Thanks for your review!")
    end

    it "does not save the review if it's invalid" do
      movie = Movie.create(movie_attributes)
      visit movie_url(movie)

      expect {
        click_button "Post Review"
      }.not_to change(Review, :count)

      # Post Review -> POST movies/:movie_id/reviews
      expect(current_path).to eq(movie_reviews_path(movie))
      expect(page).to have_text("error")
      expect(page).to have_text("Name can't be blank")
      expect(page).to have_text("Stars must be between 1 and 5")
      expect(page).to have_text("Comment is too short (minimum is 4 characters)")
    end

    it "does not allow cancellation" do
      movie = Movie.create(movie_attributes)
      visit movie_url(movie)
      expect(current_path).to eq(movie_path(movie))

      expect(page).not_to have_link("Cancel")
    end
  end
end
