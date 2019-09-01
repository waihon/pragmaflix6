class MoviesController < ApplicationController
  def index
    @movies = ["Iron Man", "Superman", "Spider-Man", "Captain America"]
  end
end
