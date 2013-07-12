class Team < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: 'team_members'
  attr_accessible :team_name, :user_id, :team_id
  
  def to_s
    team_name
  end
  
end
