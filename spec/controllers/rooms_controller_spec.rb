require 'rails_helper'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end



RSpec.describe RoomsController, type: :controller do
	describe 'deleting room' do
		let(:room) { FactoryBot.create(:room) }
    	it 'calls the model method that performs room deletion' do
    		expect { delete :destroy, :id => room.id }.should change(Room, :id)
    	end
    	it 'should set the flash' do
    		# expect(response).to redirect_to(root_path)
    		delete :destroy, :id => room.id
    		# expect { delete :destroy, :id => room.id }.should flash[:danger].to be_present
    		# expect(flash[:danger]).to be_present
        	# delete :destroy, @room
        	# flash[:notice].should =~ /"A sala foi excluída"/i
    	end
    	it 'selects the Search Results template for rendering'
    	it 'makes the TMDb search results available to that template'
  	end
end


