class CreateAccountGuestCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :account_guest_categories do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :account_guest_categories, [ :account_id, :name ]
  end
end
