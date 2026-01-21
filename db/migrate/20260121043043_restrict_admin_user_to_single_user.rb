class RestrictAdminUserToSingleUser < ActiveRecord::Migration[8.1]
  def up
    # Remove any existing admin users except the authorized one
    AdminUser.where.not(email: 'naijeria@gmail.com').destroy_all

    # Ensure the authorized user exists
    AdminUser.find_or_create_by(email: 'naijeria@gmail.com')
  end

  def down
    # No rollback needed - this is a security restriction
  end
end
