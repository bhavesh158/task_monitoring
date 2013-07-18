ActiveAdmin.register Team do

  index do
    column :id
    column :team_name
    actions defaults: true do |team|
      link_to "View Team Members", "/admin/teams/" + team.id.to_s + "/list_team_members"
    end
  end
  
  member_action :list_team_members, :method => :get do
    team = Team.find(params[:id])
    @team_members = team.team_members
  end
  
end
