class ChangeAscendIdTypeToUuid < ActiveRecord::Migration[5.2]

  def change
    add_column :ascends, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :ascends do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE ascends ADD PRIMARY KEY (id);"
  end
end
