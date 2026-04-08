class AddRoleToAccountUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :account_users, :role, :integer, null: false, default: 0
  end
end
