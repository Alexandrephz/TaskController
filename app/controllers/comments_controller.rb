class CommentsController < ApplicationController
    def new
        @task = Task.find(params[:task_id])
        @comment = @task.comments.new
      end
    
      def create
        @task = Task.find(params[:task_id])
        @comment = @task.comments.new(comment_params)
    
        if @comment.save
          respond_to do |format|
            format.html { redirect_to @task }
            format.js   # This will render create.js.erb
          end
        else
          # Handle error case
        end
      end
    
      private
    
      def comment_params
        params.require(:comment).permit(:content)
      end
    end