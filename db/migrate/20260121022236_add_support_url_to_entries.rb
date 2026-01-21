class AddSupportUrlToEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :entries, :support_url, :string
  end
end
