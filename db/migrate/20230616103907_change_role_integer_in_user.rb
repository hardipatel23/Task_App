class ChangeRoleIntegerInUser < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :role, :integer
  end
  def down
    change_column :users, :role, :string
  end
end
