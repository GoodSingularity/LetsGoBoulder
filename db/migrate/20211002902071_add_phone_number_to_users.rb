class AddPhoneNumberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_number, :int, default: 0
  end
end
