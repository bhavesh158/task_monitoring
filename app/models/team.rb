class Team < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: 'team_members'
  attr_accessible :team_name, :user_id, :team_id
  has_many :team_members
  has_many :tasks
  
  def get_user_type(user_id)
    self.team_members.where(user_id: user_id).first.user_type
  end
  
  def to_s
    team_name
  end
  
end
