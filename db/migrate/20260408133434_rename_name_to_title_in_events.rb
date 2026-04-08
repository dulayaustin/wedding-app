class RenameNameToTitleInEvents < ActiveRecord::Migration[8.1]
  def change
    rename_column :events, :name, :title
  end
end
