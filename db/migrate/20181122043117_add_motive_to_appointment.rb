class AddMotiveToAppointment < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :motive, :string
  end
end
