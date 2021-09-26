class AddStatusToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :status, :boolean, default: false
  end
end
