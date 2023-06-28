class UserShowController < ApplicationController
  def show
    @user = User.find(params[:id])
    @task = @user.assigned_tasks
  end
end
