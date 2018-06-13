require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
    describe 'Criando uma sala' do
        it 'Deveria chamar um método do controller que aloca um objeto de sala' do
            @test_room = Room.new
            assert @test_room
        end

        it 'Deveria selecionar o template new para renderização' do
        
        end

        it 'Deveria chamar um método do controller que cria um objeto da sala' do
        
        end
    end
end
