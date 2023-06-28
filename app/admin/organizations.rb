ActiveAdmin.register Organization do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :user_ids, users_attributes: [:id, :name , :email, :role,  :username]

  #
  # permit_params do
  #   permitted = [:name, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end
    f.inputs "New Organization Admin" do
      f.has_many :users  do |u|
          u.input :name
          u.input :email
          u.input :username
          u.input :role,  as: :hidden, input_html: { value: "organization_admin", readonly: true } 
      end 
    end
    f.inputs "Organization Admin" do
      organization_admins = User.organization_admin.all
      f.input :user_ids, as: :select, collection: organization_admins 
    end
    f.actions
  end
end

 
