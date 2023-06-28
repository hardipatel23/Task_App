class AddUsernameToAdminUser < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :username, :string
  end
end
