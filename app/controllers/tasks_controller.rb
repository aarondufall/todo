class TasksController < ApplicationController
  def index
    @tasks = TaskModel.order('created_at ASC').all
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
    response.headers["Location"] = url_for(root_url + "tasks/list")
    render json: {}.to_json, status: 201
  end

  def list
    @tasks = TaskModel.order('created_at ASC').all

    if @tasks.length == 0
      render json:@tasks, status: 304
    else
      Time.zone = "UTC"
      lastTimeStamp = Time.zone.parse(@tasks.last.created_at.to_s)
      modifiedSince = Time.zone.parse(request.headers['If-Modified-Since'])

      if modifiedSince <= lastTimeStamp
        result = render_to_string 'tasks/_list', locals: {tasks: @tasks}, layout: false
        render json: {
            'html' => result
        }, status: 200
      else
        render json:{}, status: 304
      end
    end
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
