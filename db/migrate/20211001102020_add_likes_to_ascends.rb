class AddLikesToAscends < ActiveRecord::Migration[6.1]
  def change
    add_column :ascends, :likes, :uuid, array: true, default: []
  end
end
