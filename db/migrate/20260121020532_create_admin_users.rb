class CreateAdminUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :admin_users do |t|
      t.string :email
      t.string :authentication_token
      t.datetime :token_expires_at

      t.timestamps
    end
    add_index :admin_users, :email, unique: true
  end
end
