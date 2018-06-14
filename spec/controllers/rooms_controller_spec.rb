require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
    describe 'GET #new' do
        context 'user.signed_in?' do
            before do 
                @user = FactoryBot.create(:user)
                sign_in @user
            end
            it 'assignes a new room to @room' do
                get :new
                expect(assigns(:room)).to be_a_new(Room)
            end
        end

        context '!user.signed_in?' do
            it 'assignes a new room to @room' do
                get :new
                expect(assigns(:room)).not_to be_a_new(Room)
            end
        end
    end
    describe 'POST #create' do
        context '!user.signed_in' do
            let(:room_params) {FactoryBot.attributes_for(:room)}
            before do
                post :create, params: {room: room_params}
            end

            it 'should not render backoffice template' do
                expect(response).not_to redirect_to(backoffice_path)
            end

            it 'should not persist through the database' do
                expect(Room.find_by(name: room_params[:name])).not_to be_truthy
            end
        end

        context 'params.valid and user.signed_in' do
            let(:room_params) {FactoryBot.attributes_for(:room)}
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

        context '!params.valid and user.signed_in' do
            let(:room_params) {FactoryBot.attributes_for(:room, :name => '')}
            before do 
                @user = FactoryBot.create(:user)
                sign_in @user
                post :create, params: {room: room_params}
            end

            it 'renders backoffice template' do
                expect(response).to redirect_to(backoffice_path)
            end

            it 'should not persist through the database' do
                expect(Room.find_by(name: room_params[:name])).not_to be_truthy
            end
        end

    end
end
