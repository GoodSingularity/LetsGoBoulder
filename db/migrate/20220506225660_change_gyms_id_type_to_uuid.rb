class ChangeGymsIdTypeToUuid < ActiveRecord::Migration[5.2]
  def change
    remove_column :gyms, :id
    add_column :gyms, :uuid, :uuid, default: "gen_random_uuid()", null: false
    execute "ALTER TABLE gyms ADD PRIMARY KEY (uuid);"
    change_table :gyms do |t|
      t.rename :uuid, :id
    end
  end
end
