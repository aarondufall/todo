class TasksController < ApplicationController
  def index
    @tasks = TaskModel.order('created_at ASC').all

    if request.xhr?
      if @tasks.length == 0
        render json: @tasks, status: 304
      elsif cache_constraint = request.headers['If-Modified-Since']
        latest_task = @tasks.max_by(&:updated_at)

        cache_constraint = Time.parse(cache_constraint)

        if cache_constraint <= latest_task.updated_at
          html = render_to_string(
            'tasks/_list',
            locals: { tasks: @tasks },
            layout: false
          )

          render text: html, status: 200
        else
          head 304
        end
      end
    end
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
    response.headers["Location"] = tasks_path

    head status: 201
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
