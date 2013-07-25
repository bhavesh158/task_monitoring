class TaskCommentMailer < ActionMailer::Base
  default from: "support@grepruby.com"
  
  def new_task_comment_notification(task_comment, current_user)
    @current_user_type = TeamMember.where(user_id: current_user).first.user_type
    if @current_user_type == "Team Lead"
      @current_user = User.where(id: current_user).first
      @task_comment = task_comment
      @task = Task.where(id: @task_comment.task_id).first
      @task_team = Team.where(@task.team_id).first
      @user = User.where(id: Task.find(@task_comment.task_id).user_id).first
      mail(to: @user.email, subject: 'New task comment for you')
    else
      @current_user = User.where(id: current_user).first
      @task_comment = task_comment
      @task = Task.where(id: @task_comment.task_id).first
      @task_team = Team.where(@task.team_id).first
      @team_lead = @task_team.team_members.where(user_type: "Team Lead").first
      @user = User.where(id: @team_lead.user_id).first
      mail(to: @user.email, subject: 'New task comment for you')
    end
  end
  
end
