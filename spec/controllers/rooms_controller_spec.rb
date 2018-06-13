require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
	describe 'listing rooms as adm' do
		it 'calls the model method that performs TMDb search' do
      		spost :search_tmdb, {:search_terms => 'hardware'}
    	end
    	it 'selects the Search Results template for rendering'
    	it 'makes the TMDb search results available to that template'
	end

end
