class AddTamanhoToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :tamanho, :int
  end
end
