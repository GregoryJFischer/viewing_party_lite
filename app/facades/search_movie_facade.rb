class SearchMovieFacade
  def initialize(query)
    @query = query
  end

  def service
    MovieService.new
  end

  def movies
    films_1 = service.search_1(@query)
    films_2 = service.search_2(@query)

    films = films_1[:results] + films_2[:results]

    films.map do |film|
      Movie.new(film)
    end
  end
end