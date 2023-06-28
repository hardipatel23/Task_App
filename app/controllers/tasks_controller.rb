class TasksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_current_organization
  before_action :set_task, only: [:show, :destroy, :edit, :update]
  before_action :check_admin_role, only: [:create, :destroy, :new]
  before_action :authorize_task_access, only: [:show, :edit, :update]

  def index
    @tasks = @current_organization.tasks
  end

  def new
    @task = @current_organization.tasks.new
  end

  def create
    @task = @current_organization.tasks.new(task_params)
    @task.status = 'ToDo'
    if @task.save
      redirect_to @task, notice: 'Task created successfully.'
    else  
      render :new
    end
  end

  def edit
    @task = @current_organization.tasks.find(params[:id])
    @assignees = @current_organization.users.where.not(role: 'organization_admin')

    if  @task.assignee == @task.approver 
      @status_options = Task.statuses.slice(:in_progress, :in_review, :approved, :rejected).keys
    elsif current_user.organization_admin? && @task.assignee == current_user
      @status_options = Task.statuses.slice(:in_progress, :in_review, :todo, :closed).keys
    elsif  current_user.organization_admin? && @task.approver == current_user 
      @status_options = Task.statuses.slice(:approved, :rejected, :todo, :closed).keys
    else
      if @task.assignee == current_user
        @status_options = Task.statuses.slice(:in_progress, :in_review).keys
      elsif @task.approver == current_user  && (@task.status == 'in_review')
        @status_options = Task.statuses.slice(:approved, :rejected).keys
      elsif current_user.organization_admin?  && (@task.status == 'approved' || @task.status == 'rejected')
        @status_options = Task.statuses.slice(:todo, :closed).keys
      else
        @status_options = []
      end
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task updated successfully.'
    else
      redirect_to @task, alert: 'Failed to update the task.'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task deleted successfully.'
  end

  def show
  end

  private

  def set_current_organization
    @organizations = current_user.organizations
    @current_organization = current_user.current_organization || @organizations.first
  end

  def set_task
    @task = @current_organization.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :assignee_id, :approver_id, :status, :start_date, :end_date, :repeat_task, :frequency, :due_date)
  end

  def check_admin_role
    unless current_user.organization_admin?
      redirect_to root_url, alert: 'You are not authorized to perform this action.'
    end
  end

  def authorize_task_access
    super(@task)
  end
  
end
