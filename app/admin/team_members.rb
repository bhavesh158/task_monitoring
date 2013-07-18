ActiveAdmin.register TeamMember do
  
  actions :all, :except => [:edit]
  
  controller do
    def create
      team_member_ids = params[:team_member][:user_id].reject! { |id| id.empty? }
      team_lead = User.where(:id => params[:team_member][:user_type]).first
      team = Team.where(:id => params[:team_member][:team_id]).first
      team_member_ids.each do |team_member_id|
        user = User.where(:id => team_member_id).first
        user_type = (user.email == team_lead.email) ? "Team Lead" : "Associate"
        team.team_members.create(user_id: user.id, user_type: user_type)
      end
        flash[:success] = "Team has been successfully created."
        redirect_to admin_team_members_path
    end
  end
  
  index do
    column :id
    column :team
    column :user
    column :user_type
    actions defaults: true
  end
  
  form do |f|
    f.inputs do
      f.input :team, include_blank: false
      f.input :user, as: :select, multiple: true, include_blank: false
      f.input :user_type, as: :select, 
               label: "Team Lead", include_blank: false,
               collection: User.all.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
    end
    f.actions 
  end

end
