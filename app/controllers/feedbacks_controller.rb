class FeedbacksController < InheritedResources::Base
  
  def index
    @user = User.where(id: params[:user_id]).first
    @team = Team.where(id: params[:team_id]).first
    @team_members = @team.team_members.where(team_id: @team.id)
    @team_lead = @team_members.where(user_type: "Team Lead").first
    @team_lead_user = User.where(id: @team_lead.user_id).first
    @feedbacks = @user.feedbacks.where(team_id: params[:team_id])
  end
  
  def new
    @feedback = Feedback.new
    @team = Team.where(id: params[:team_id]).first
    @user = User.where(id: params[:user_id]).first
  end

  def create
    @feedback = Feedback.new(team_id: params[:team_id], user_id: params[:user_id], content: params[:feedback][:content])
    if @feedback.save
      redirect_to team_team_tasks_path(id: params[:team_id]), notice: "Task has been created"
    else
      redirect_to new_team_user_feedback_path(team_id: params[:team_id], user_id: params[:user_id]), alert: "Could not leave FeedBack empty "
    end
  end

  def destroy
    @feedback = Feedback.where(id: params[:id]).first
    if @feedback.destroy
      redirect_to team_user_feedbacks_path(params[:team_id], params[:user_id])
    end
  end

end
