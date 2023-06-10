class TasksController < ApplicationController
    def index
      @date_method = (params[:search].present? ? params[:search][:date_method] : 'indate').to_sym
      @start = selected_date(:start_date)
      @end = selected_date(:end_date)
      if current_user.has_role?(:admin)
        @roles = Role.pluck(:name)
        @tasks_ids = TasksRole.all
        @tasks = params[:search].present? ? Task.all.joins(:users).select("tasks.*, users.username").where(@date_method => @start..@end).order(task_urgency: :desc) : Task.all.joins(:users).select("tasks.*, users.username").order(task_urgency: :desc)
        @tasks_normal = @tasks.select { |x| x.task_urgency == 1 }
        @tasks_prioridade = @tasks.select { |x| x.task_urgency == 2 }
        @tasks_urgente = @tasks.select { |x| x.task_urgency == 3 }
        
      else
        @users = current_user
        @roles = @users.roles.pluck(:id)
        @tasks_ids = params[:search].present? ? TasksRole.where(role_id: @role_task).pluck(:task_id) : TasksRole.where(role_id: @roles).pluck(:task_id)
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
    def filter_by_date
      start_date = params[:start_date].to_date
      end_date = params[:end_date].to_date
  
      @tasks = Task.where(task_expire: start_date..end_date)
  
      respond_to do |format|
        format.js
      end
    end

  
    private
      def task_params
        params.require(:task).permit(:task_name, :task_content, :task_urgency, :task_expire, role_ids: [],user_ids: [])
      end

      def selected_date(symbol)
        params[:search].present? && params[:search][symbol].present? ? params[:search][symbol].to_date : Time.now.to_date
    end
  end