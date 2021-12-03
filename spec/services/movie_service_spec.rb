require 'rails_helper'

RSpec.describe 'Movie Service', :vcr do
  before :each do
    @service = MovieService.new
  end
  it 'can return top_films' do
    page_1 = @service.films_1
    page_2 = @service.films_2
    films = page_1[:results] + page_2[:results]
    first_film = films.first

    expect(page_1).to be_a(Hash)
    expect(films).to be_an(Array)
    expect(films.count).to eq(40)
    expect(first_film[:title]).to be_a(String)
    expect(first_film[:vote_average]).to be_a(Float)
    expect(first_film[:poster_path]).to be_a(String)
    expect(first_film[:overview]).to be_a(String)
    expect(first_film[:genre_ids]).to be_an(Array)
  end

  it 'can return films by keyword' do
    search = @service.search_1('Pee Wee')
    films = search[:results]
    first_film = films.first

    expect(search).to be_a(Hash)
    expect(films).to be_an(Array)
    expect(films.count).to eq(12)
    expect(first_film[:title]).to be_a(String)
    expect(first_film[:vote_average]).to be_a(Integer)
    expect(first_film[:poster_path]).to be_a(String)
    expect(first_film[:overview]).to be_a(String)
    expect(first_film[:genre_ids]).to be_an(Array)
  end

  it 'returns a movies details' do
    details = @service.details(75)

    expect(details).to be_a(Hash)
    expect(details[:title]).to be_a(String)
    expect(details[:vote_average]).to be_a(Float)
    expect(details[:poster_path]).to be_a(String)
    expect(details[:overview]).to be_a(String)
    expect(details[:genres]).to be_an(Array)
    expect(details[:runtime]).to be_a(Integer)
  end
end
