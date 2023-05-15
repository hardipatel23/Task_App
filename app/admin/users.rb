ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation, :role, :organization_id

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    column "organization" do |o|
      u = Organization.find(o.organization_id).name
    end
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter "organization" do |o|
   u = Organization.find(o.organization_id).name
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, :as => :select, collection: User.roles.keys.to_a 
      f.input :organization_id, :as => :select, collection: Organization.all
    end
    f.actions
  end
  
end
