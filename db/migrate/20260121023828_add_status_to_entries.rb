class AddStatusToEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :entries, :status, :string, default: 'published'
    add_index :entries, :status
  end
end
