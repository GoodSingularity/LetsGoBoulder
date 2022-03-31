class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.uuid :user_id
      t.uuid :gym_id
      t.datetime :starts_at
      t.boolean :status
      t.timestamps
    end
  end
end
