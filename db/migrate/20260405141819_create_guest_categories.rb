class CreateGuestCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :guest_categories do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
