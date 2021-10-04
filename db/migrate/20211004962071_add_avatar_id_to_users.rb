class AddAvatarIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar_id, :uuid, default: "gen_random_uuid()", null: false
  end
end
