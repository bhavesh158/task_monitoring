class TeamsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @my_teams = current_user.teams
  end
  
  def team_tasks
    @team = Team.find(params[:team_id])
    @tasks = @team.tasks
    @user = @team.team_members.map{ |team_member| team_member.user }
  end

end
