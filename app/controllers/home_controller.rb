class HomeController < ApplicationController
  def index
    if current_user
      @organizations = current_user.organizations
      if current_user.organization_admin?
        if params[:organization_id].present?
          @current_organization = @organizations.find(params[:organization_id])
          current_user.current_organization = @current_organization
          current_user.save
        else
          @current_organization = current_user.current_organization || @organizations.first
        end
      else
        @current_organization = current_user.organizations #organization
      end
        @current_organization = current_user.current_organization || @organizations.first
        @tasks = @current_organization.tasks
        @users = @current_organization.users
    else
      render ...
    end
  end
end
