require 'rails_helper'

RSpec.describe 'Movies Show Page' do
  describe 'when a user visits the movie show page' do
    before :each do
      @user_1 = create(:user)

      visit '/login'

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password

      click_button

      @facade = MovieDetailsFacade.new(75, @user_1.id)
      @movie = @facade.movie
      visit "/movies/#{@movie.id}"
    end

    it 'has a button to create a viewing party', :vcr do
      click_button "Create Viewing Party"
      expect(current_path).to eq("/movies/#{@movie.id}/viewing-party/new")
    end

    it 'has a button to return to the discover page', :vcr do
      click_button "Discover Movies"
      expect(current_path).to eq("/discover")
    end

    it 'displays relevant movie information', :vcr do
      within("#details") do
        expect(page).to have_content("Vote Average: #{@movie.rating}")
        expect(page).to have_content("Runtime: #{@movie.formated_time}")
        expect(page).to have_content(@movie.genres.first[:name])
      end
      within('#summary') do
        expect(page).to have_content("Summary: 'We come in peace' is not what those green men from Mars mean when they invade our planet, armed with irresistible weapons and a cruel sense of humor. This star studded cast must play victim to the alien’s fun and games in this comedy homage to science fiction films of the '50s and '60s.")
      end
    end

    it 'displays a films reviews and their authors', :vcr do
      review = @facade.reviews.first
      within("#reviews") do
        expect(page).to have_content("#{@facade.reviews.count} Reviews")
        expect(page).to have_content("Author: #{review.author}")
        expect(page).to have_content("Good watch, could watch again, but it's hard to honestly recommend.\r \r This is one of those movies that is good because it is bad, whether or not that is done on purpose, for the purposes of parody. Otherwise it's just a good old jump in \"The Way Back Machine\" to see a litany of cameos or cheap parts by almost anyone who was famous in the mid-1990s. Though I do feel like most of the actors I liked were essentially wasted, but it is possible that was by design so the Martians could keep the focus for the majority of the movie.\r \r Rethinking on the movie almost makes me want a modernization, it has so many little quirks and nuances that really brings it to a special experience. Even if you think it looks terrible, throw this on your queque and slot it in for a Bad Movie Night.")
      end
    end
  end
end
