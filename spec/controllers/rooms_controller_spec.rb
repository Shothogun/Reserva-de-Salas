require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  let(:user) {
    FactoryBot.create(:user)
  }

  let(:room) {
    FactoryBot.create(:room)
  }

  describe "GET Rooms" do
    context "Usuário está logado" do

      it "Retorna uma resposta 200 ao acessar a página de salas estando logado" do
        sign_in user
        get :index
        expect(response.status).to eq(200)
      end

      it "Carrega o template do index de todas as salas disponíveis" do
        sign_in user
        get :index
        expect(response).to render_template("index")
      end

      it "Retorna uma lista com as salas disponíveis" do
        sign_in user
        get :index
        expect(assigns(:rooms)).to match_array(room)
      end

    end

    context "Usuário está deslogado" do

      it "Retorna resposta 302 ao acessar a página de salas estando deslogado" do
        get :index
        expect(response.status).to eq(302)
      end

    end

  end

end
