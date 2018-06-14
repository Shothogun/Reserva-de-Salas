require 'rails_helper'



RSpec.describe RoomsController, type: :controller do



	# describe 'deleting room' do
 #    	it 'calls the model method that performs room deletion' do
 #    		expect { delete :destroy, :id => room.id }.should change(Room, :id)
 #    	end
 #    	it 'should set the flash' do
 #    		expect(request.flash[:danger]).not_to be_nil
 #    	end
 #  	end
 describe "DELETE #destroy" do
 	context 'quando admin está logado' do
 		before do 
 			@user = FactoryBot.create(:user)
 			sign_in user
 			@room = FactoryBot.create(:room)
 		end
 		it 'find a room to delete' do
 			
 		end
 	end
 end
end


# DELETE /rooms/:id(.:format)           rooms#destroy