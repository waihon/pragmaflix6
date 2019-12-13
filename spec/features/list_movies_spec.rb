require 'rails_helper'

describe "Viewing the list of movies" do
  it "shows the movies" do
    movie1 = Movie.create(title: "Iron Man",
                          rating: "PG-13",
                          total_gross: 318_412_101.00,
                          description: "Tony Stark builds an armored suit to fight the throes of evil",
                          duration: "126 min",
                          released_on: "2008-05-02")

      movie2 = Movie.create(title: "Superman",
                            rating: "PG",
                            total_gross: 134_218_018.00,
                            description: "Clark Kent grows up to be the greatest super-hero",
                            duration: "143 min",
                            released_on: "1978-12-15")

      movie3 = Movie.create(title: "Spider-Man",
                            rating: "PG-13",
                            total_gross: 403_706_375.00,
                            description: "Peter Parker gets bit by a genetically modified spider",
                            duration: "121 min",
                            released_on: "2002-05-03")

    visit movies_url

    expect(page).to have_text(movie1.title)
    expect(page).to have_text(movie2.title)
    expect(page).to have_text(movie3.title)

    expect(page).to have_text(movie1.description[0..10])
    expect(page).to have_text("$318,412,101")
  end

  it "does not show a movie that hasn't yet been released" do
    movie1 = Movie.create(title: "Iron Man",
                          rating: "PG-13",
                          total_gross: 318_412_101.00,
                          description: "Tony Stark builds an armored suit to fight the throes of evil",
                          duration: "126 min",
                          released_on: -1.day.from_now)

    movie2 = Movie.create(title: "Superman",
                          rating: "PG",
                          total_gross: 134_218_018.00,
                          description: "Clark Kent grows up to be the greatest super-hero",
                          duration: "143 min",
                          released_on: 1.day.from_now)

    visit movies_url

    expect(page).to have_text(movie1.title)
    expect(page).not_to have_text(movie2.title)
  end
end
