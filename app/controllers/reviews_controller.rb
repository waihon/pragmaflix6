class ReviewsController < ApplicationController
  def index
    @movie = Movie.find_by(id: params[:movie_id])
    @reviews = @movie && @movie.reviews  
  end

  def new
    @movie = Movie.find_by(id: params[:movie_id])
    @review = @movie.reviews.new
  end
end
