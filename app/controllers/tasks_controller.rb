class TasksController < InheritedResources::Base 
  
  before_filter :authenticate_user!
  
  def index
    teams = TeamMember.where(user_id: current_user.id).map{|m| m.team}
    @tasks = []
    teams.each do |team|
      @tasks += team.tasks
    end
  end
  
  def new
    @task = Task.new
    @team = Team.find(params[:team_id])
    @team_members = @team.team_members.map {|m| m.user_id}
    @team_members_names = []
    @team_members.each do |team_member|
      if team_member != current_user.id
        @team_members_names << User.where(id: team_member).map{|f| f.id.to_s + " " + f.first_name + " " + f.last_name}
      end
    end
  end
  
  def create
    team = Team.where(team_name: params[:task][:team_id]).first
    @user = User.where(id: params[:task][:user_id].split(" ").first).first
    @task = Task.new(team_id: team.id, user_id: @user.id, title: params[:task][:title], details: params[:task][:details])
    if @task.save
      TaskMailer.new_task_notification(@task, @user).deliver
      redirect_to tasks_path, notice: "Task has been created"
    else
      redirect_to new_task_path(team_id: team.id), alert: "Could not leave Task Title and/or Task Detials empty "
    end
  end
  
  def show
    @task_details = Task.find(params[:id])
    @team_details = Team.find(@task_details.team_id)
    @user_details = User.find(@task_details.user_id)
    
  end
  
  def edit
    @task = Task.find(params[:id])
    @team = Team.where(id: @task.team_id).first
    @team_members = @team.team_members.map {|m| m.user_id}
    @team_members_names = []
    @team_members.each do |team_member|
      if team_member != current_user.id
        @team_members_names << User.where(id: team_member).map{|f| f.id.to_s + " " + f.first_name + " " + f.last_name}
      end
    end
  end
  
  def update
    task = Task.find(params[:id])
    team = Team.where(team_name: params[:task][:team_id]).first
    @user = User.where(id: params[:task][:user_id].split(" ").first).first
    if task.update_attributes(team_id: team.id, user_id: @user.id, title: params[:task][:title], details: params[:task][:details], status: params[:task][:status])
      redirect_to tasks_path, notice: "Task has been successfully updated"
    else
      redirect_to new_task_path(team_id: team.id), alert: "Could not leave Task Title and/or Task Detials empty"
    end
  end
  
end
