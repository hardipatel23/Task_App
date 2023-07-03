class ApplicationController < ActionController::Base
    # before_action :authenticate_user!

    private
  
    def authorize_task_access(task)
      unless current_user.organizations.exists?(task.organization_id)
        redirect_to root_path, alert: 'You are not authorized to access this task.'
      end
    end 

end
