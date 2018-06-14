require 'rails_helper'



RSpec.describe RoomsController, type: :controller do



 describe "GET #destroy" do
 	context 'quando admin está logado' do
 		before do 
 			@user = FactoryBot.create(:user)
 			sign_in @user
 			@room = FactoryBot.create(:room)
 		end
 		it 'encontrar a sala para deletar' do
 			get :edit, params: {id: @room.id}
 			expect(response.status).to eq(200)
 		end
 	end
 end

 describe "DELETE #destroy" do 
 	before do 
		@user = FactoryBot.create(:user)
		sign_in @user
		@room = FactoryBot.create(:room)
		
	end
	it 'deletar a sala' do
		delete :destroy, params: {id: @room.id}
		expect(response.status).to eq(302)
	end

 end

end
