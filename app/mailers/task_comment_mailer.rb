class TaskCommentMailer < ActionMailer::Base
  default from: "support@grepruby.com"
  
  def new_task_comment_notification(task_comment, current_user_id)
    @current_user_type = TeamMember.where(user_id: current_user_id).first.user_type
    @current_user = User.where(id: current_user_id).first
    @task_comment = task_comment
    @task = Task.where(id: @task_comment.task_id).first
    @task_team = Team.where(id: @task.team_id).first
    if @current_user_type == "Team Lead"
      @user = User.where(id: Task.find(@task_comment.task_id).user_id).first
      mail(to: @user.email, subject: 'New task comment for you')
    else
      @team_lead = @task_team.team_members.where(user_type: "Team Lead").first
      @user = User.where(id: @team_lead.user_id).first
      mail(to: @user.email, subject: 'New task comment for you')
    end
  end
  
end
