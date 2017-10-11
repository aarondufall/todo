class TasksController < ApplicationController
  def index
    @tasks = TaskModel.all
  end

  def create
    name = params[:name]

    if name.nil? || name == ''
      flash[:error] = "Task creation failed! Name not specified"
      redirect_to tasks_path and return
    end

    task_id = Identifier::UUID::Random.get

    Task::Commands::Add.(name, task_id: task_id)

    flash[:notice] = "Task added successfully"
    redirect_to tasks_path
  end

  def update
    @task = TaskModel.find(params[:id])
    if @task.update(task_update_params)
      redirect_to tasks_path
    else
      flash[:error] = "Task failed to update! #{print_errors(@task)}"
      redirect_to tasks_path
    end
  end

  def destroy
    @task = TaskModel.find(params[:id])
    if @task.delete
      redirect_to tasks_path
    else
      flash[:error] = "Task deletion failed! #{print_errors(@task)}"
      redirect_to tasks_path
    end
  end

  def task_update_params
    params.permit(:name, :completed_flag)
  end

  def print_errors task
    task.errors.full_messages.join(", ") + "."
  end
end
