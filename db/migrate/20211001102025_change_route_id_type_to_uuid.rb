class ChangeRouteIdTypeToUuid < ActiveRecord::Migration[5.2]

  def change
    add_column :routes, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :routes do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE routes ADD PRIMARY KEY (id);"
  end
end
