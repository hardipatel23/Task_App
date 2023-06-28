class RemoveOrganizationRefFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :organization
  end
end
