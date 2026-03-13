class AddEnumColumnsToGuests < ActiveRecord::Migration[8.1]
  def change
    add_column :guests, :age_group, :integer
    add_column :guests, :guest_of, :integer
  end
end
