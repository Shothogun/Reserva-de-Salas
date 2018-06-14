require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
    describe 'GET #new' do
        before do 
            @user = FactoryBot.create(:user)
            sign_in @user
        end
        it 'assignes a new room to @room' do
            get :new
            expect(assigns(:room)).to be_a_new(Room)
        end
    end

    describe 'POST #create' do
        let(:room_params) {FactoryBot.attributes_for(:room)}
        context 'when params are valid'
            before do 
                @user = FactoryBot.create(:user)
                sign_in @user
                post :create, params: {room: room_params}
            end

            it 'renders backoffice template' do
                expect(response).to redirect_to(backoffice_path)
            end

            it 'should persist through the database' do
                expect(Room.find_by(name: room_params[:name])).to be_truthy
            end
        

    end
end
