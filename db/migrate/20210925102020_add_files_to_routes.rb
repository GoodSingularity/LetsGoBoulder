class AddFilesToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :files, :string, array: true, default: []
  end
end
