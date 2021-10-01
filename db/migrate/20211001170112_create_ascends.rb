class CreateAscends < ActiveRecord::Migration[6.1]
  def change
    create_table :ascends do |t|
      t.uuid :route_id
      t.uuid :user_id
      t.timestamps
    end
  end
end
