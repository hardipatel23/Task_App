ActiveAdmin.register AdminUser do

  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    actions
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    before_action :check_admin_user_exists, only: [:create]

    def check_admin_user_exists
        if AdminUser.exists?
          flash[:error] = "Only one admin user can be created."
          redirect_to admin_admin_users_path
        else
          super
        end
    end
  end

end
