class CreateEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :entries do |t|
      t.date :date
      t.text :body
      t.string :support_url

      t.timestamps
    end
  end
end
