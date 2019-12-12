class ReviewsController < ApplicationController
  def index
    @movie = Movie.find_by(id: params[:movie_id])
    @reviews = @movie && @movie.reviews  
  end

  def new
    @movie = Movie.find_by(id: params[:movie_id])
    @review = @movie.reviews.new
  end

  def create
    @movie = Movie.find_by(id: params[:movie_id])
    @review = @movie.reviews.new(review_params)
    if @review.save
      redirect_to movie_reviews_url(@movie), notice: "Thanks for your review!"
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :stars, :comment)
  end

end
