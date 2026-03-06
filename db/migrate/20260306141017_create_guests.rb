class CreateGuests < ActiveRecord::Migration[8.1]
  def change
    create_table :guests do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end
  end
end
