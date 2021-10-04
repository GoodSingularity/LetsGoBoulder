class AddIsFlashedToAscends < ActiveRecord::Migration[6.1]
  def change
    add_column :ascends, :is_flashed, :boolean, default: false
  end
end
