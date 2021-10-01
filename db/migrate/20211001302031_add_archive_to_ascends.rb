class AddArchiveToAscends < ActiveRecord::Migration[6.1]
  def change
    add_column :ascends, :archive, :boolean, default: false
  end
end
