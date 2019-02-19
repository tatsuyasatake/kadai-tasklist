class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
      @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
      set_task
  end

  def new
      @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_path
    else
      
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
    set_task
  end

  def update
    set_task
    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_to tasks_path
  end

  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end
end
