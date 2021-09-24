class CreateRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :routes do |t|
      t.string :name
      t.integer :color
      t.string :route_setter

      t.timestamps
    end
  end
end
