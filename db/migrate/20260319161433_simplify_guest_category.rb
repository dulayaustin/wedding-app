class SimplifyGuestCategory < ActiveRecord::Migration[8.1]
  def up
    add_reference :guests, :account_guest_category, null: true, foreign_key: true

    execute <<~SQL
      UPDATE guests
      SET account_guest_category_id = gc.account_guest_category_id
      FROM guest_categories gc
      WHERE gc.guest_id = guests.id
    SQL

    change_column_null :guests, :account_guest_category_id, false

    drop_table :guest_categories
  end

  def down
    create_table :guest_categories do |t|
      t.references :guest, null: false, foreign_key: true
      t.references :account_guest_category, null: false, foreign_key: true
      t.timestamps
    end

    execute <<~SQL
      INSERT INTO guest_categories (guest_id, account_guest_category_id, created_at, updated_at)
      SELECT id, account_guest_category_id, NOW(), NOW()
      FROM guests
    SQL

    remove_reference :guests, :account_guest_category, foreign_key: true
  end
end
