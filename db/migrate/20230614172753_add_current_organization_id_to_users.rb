class AddCurrentOrganizationIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :current_organization_id, :integer
  end
end
