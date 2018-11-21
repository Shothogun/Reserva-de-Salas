class CreateAppointbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :appointbacks do |t|
      t.datetime :appointback_date
      t.time :start_time
      t.integer :status
      t.references :user
      t.references :room
      t.timestamps
    end
  end
end
