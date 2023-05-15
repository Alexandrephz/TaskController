class TasksController < ApplicationController
    def index
      if current_user.has_role?(:admin)
        @tasks = Task.all.joins(:users).select("tasks.*, users.username")
        @tasks_normal = @tasks.select { |x| x.task_urgency == 1 }
        @tasks_prioridade = @tasks.select { |x| x.task_urgency == 2 }
        @tasks_urgente = @tasks.select { |x| x.task_urgency == 3 }

      else
        @users = current_user
        @roles = @users.roles.pluck(:id)
        @tasks_ids = TasksRole.where(role_id: @roles).pluck(:task_id)
        @tasks = Task.where(id: @tasks_ids).joins(:users).select("tasks.*, users.username")
        @tasks_normal = @tasks.select { |x| x.task_urgency == 1 }
        @tasks_prioridade = @tasks.select { |x| x.task_urgency == 2 }
        @tasks_urgente = @tasks.select { |x| x.task_urgency == 3 }

      end

    end
    def show
      @task = Task.find(params[:id])
      @comments = @task.comments
      puts @comments
      respond_to do |format|
        format.js
      end

    rescue ActionController::UnknownFormat
      render status: 404, text: "Not Found"
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
    def update_status
      @task = Task.find(params[:id])
      if @task.task_status == false 
        @task.update(task_status: true)
      else
        @task.update(task_status: false)
      end
      respond_to do |format|
        format.js
      end
    end

  
    private
      def task_params
        params.require(:task).permit(:task_name, :task_content, :task_urgency, :task_expire, role_ids: [],user_ids: [])
      end
  end