class CommentsController < ApplicationController

  before_action :set_task
  before_action :set_comment, only: [ :edit, :update, :destroy]
  before_action :authorize_comment_access, only: [:edit, :update]

  def index
    @comments = @task.comments
  end

  def new
    @comment = @task.comments.build 
    respond_to do |format|
      format.js #new.js.erb
    end
  end

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to task_path(@task), notice: 'Comment created successfully.'
    else
      render :new
    end
  end

  def edit
   
  end

  def update
    if @comment.update(comment_params)
      redirect_to task_path(@task), notice: 'Comment updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to task_path(@task), notice: 'Comment deleted successfully.'
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = @task.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :created_at)
  end
  
  def authorize_comment_access
    unless @comment.user_id == current_user&.id
      redirect_to root_path, alert: 'You are not authorized to access this comment.'
    end
  end 

end
