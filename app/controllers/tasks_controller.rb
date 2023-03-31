class TasksController < ApplicationController
    def index
      @tasks = Task.all.joins(:users).select("tasks.*, users.username")
      @tasks_normal = @tasks.select { |x| x.task_urgency == 1 }

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
        @roles = @users.roles.pluck(:name,:id)
        
      end
  
    end
    def create
      @task = Task.new(task_params)
      @task.user_ids = current_user.id
  
      if @task.save
        redirect_to @task
      else
        render :new, status: :unprocessable_entity
      end
    end
    private
      def task_params
        params.require(:task).permit(:task_name, :task_content, :task_urgency, :task_expire, role_ids: [],user_ids: [])
      end
  end