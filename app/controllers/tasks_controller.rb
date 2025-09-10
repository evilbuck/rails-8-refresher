class TasksController < ApplicationController
  before_action :set_project, only: [ :create, :destroy, :update ]
  before_action :set_task, only: [ :destroy ]


  def index
  end

  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      render turbo_stream: [
        turbo_stream.append("tasks", partial: "tasks/task", locals: { task: @task }),
        turbo_stream.replace("new_task_form", partial: "tasks/form", locals: { project: @project, task: @project.tasks.build })
      ]
    else
      # render turbo_stream: turbo_stream.replace("new_task_form", partial: "tasks/form", locals: { project: @project, task: @task })
      # TODO: show error to user somehow
    end
  end

  def update
    @task = @project.tasks.find(params[:id])

    if @task.save
      render turbo_stream: [
        turbo_stream.replace("task-#{@task.id}", partial: "tasks/task", lacals: { task: @task })
      ]
    else
      # TODO: show error to user somehow
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.expect(task: [:title, :order, :completed])
  end

  def destroy
    @task.destroy

    render turbo_stream: turbo_stream.remove(@task)

    head :not_found
  end
end
