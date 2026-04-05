class RemoveGuestCategories < ActiveRecord::Migration[8.1]
  def up
    remove_foreign_key :guests, :guest_categories
    drop_table :guest_categories
  end
end
