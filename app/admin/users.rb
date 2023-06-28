ActiveAdmin.register User do

  permit_params :name, :email, :role, :username, :organization_ids

  index do 
    selectable_column   
    id_column
    column :name
    column :username
    column :email
    column :role
    column "organizations" do |user|
      user.organizations.pluck(:name).join(', ')
    end
    column :created_at
    actions
  end

  show do 
    attributes_table do
      row :id
      row :name
      row :username
      row :email
      row :role
      row :created_at
      row :updated_at
      row "Organizations" do |user|
        user.organizations.pluck(:name).join(', ')
      end
    end
  end



  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :username
      f.input :email
      f.input :role, as: :select, collection: User.roles.keys
      f.input :organization_ids, as: :select, collection: Organization.all
    end  
    f.actions
  end

end
