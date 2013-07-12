class TeamMember < ActiveRecord::Base
  belongs_to :team
  belongs_to :user 
  attr_accessible :user_type, :team_id, :user_id
end
