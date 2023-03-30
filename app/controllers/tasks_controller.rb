class TasksController < ApplicationController
    def index
      @users = User.with_role :admin
      @tasks = Task.all
    end
    def show
      @task = Task.find(params[:id])
    end
    def new
      @task = Task.new
      if current_user.has_role?(:admin)
        @roles = Role.pluck(:name,:id)
      else
        @users = current_user
        @roles = @users.roles.map(&:name)
      end
  
    end
    def create
      @task = Task.new(task_params)
  
      if @task.save
        redirect_to @task
      else
        render :new, status: :unprocessable_entity
      end
    end
    private
      def task_params
        params.require(:task).permit(:task_name, :task_content, :task_expire, :task_files, :task_urgency, role_ids: [])
      end
  end