class CreateGuestCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :guest_categories do |t|
      t.references :guest, null: false, foreign_key: true
      t.references :account_guest_category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :guest_categories, [ :guest_id, :account_guest_category_id ]
  end
end
