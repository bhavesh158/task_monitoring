class TaskCommentsController < InheritedResources::Base
  
  def create
    @task_comment = current_user.task_comments.create(params[:task_comment])
    @task_comment.task_id = params[:task_id]
    if @task_comment.save
      TaskCommentMailer.new_task_comment_notification(@task_comment, current_user.id).deliver
      redirect_to task_path(@task_comment.task_id)
    else
      redirect_to task_path(params[:task_id]), alert: "Could not leave message empty "
    end
  end
  
  def download_attachment
    @task_comment = TaskComment.where(id: params[:task_comment_id]).first
    send_file @task_comment.comment_attachment.path
  end
  
  def destroy
    @task_comment = TaskComment.where(id: params[:id]).first
    if @task_comment.destroy
      redirect_to task_path(params[:task_id])
    end
  end
  
end
