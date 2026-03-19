class RenameAccountGuestCategoriesToGuestCategories < ActiveRecord::Migration[8.1]
  def change
    rename_table :account_guest_categories, :guest_categories
    rename_column :guests, :account_guest_category_id, :guest_category_id
  end
end
