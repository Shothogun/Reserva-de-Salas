class AddTmotivoToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :motivo, :string
  end
end
