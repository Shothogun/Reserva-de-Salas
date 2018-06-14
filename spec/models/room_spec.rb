require 'rails_helper'

RSpec.describe Room, type: :model do

  describe "CREATE Room" do
    
    context "Caso feliz" do
      it "Cria uma nova sala com os parametros corretos" do
        expect { 
          Room.new(name: "Sala Maneira", location: "ICC Norte").save! 
        }.to change(Room, :count).by(1)
      end
    end

    context "Casos tristes" do
      it "Erro ao tentar salvar salas sem o nome" do
        expect { 
          Room.new(location: "ICC Norte").save! 
        }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "Erro ao tentar salvar nomes menores que 3" do
        expect { 
          Room.new(name: "S", location: "ICC Norte").save! 
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

  end
end
