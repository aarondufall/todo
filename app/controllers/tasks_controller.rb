class TasksController < ApplicationController
  def index
    @tasks = Task::Queries::All.()
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
    task_id = params[:id]

    if params[:completed_flag] == "true"
      Task::Commands::Complete.(task_id: task_id)
    elsif params[:completed_flag] == "false"
      Task::Commands::MarkIncomplete.(task_id: task_id)
    else
      head :bad_request and return
    end

    flash[:notice] = "Task updated successfully"
    redirect_to tasks_path
  end

  def destroy
    task_id = params[:id]

    Task::Commands::Remove.(task_id: task_id)

    flash[:notice] = "Task removed"
    redirect_to tasks_path
  end
end
