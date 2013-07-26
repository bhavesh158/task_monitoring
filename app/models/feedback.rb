class Feedback < ActiveRecord::Base

  belongs_to :team
  belongs_to :user
  
  validates :content, presence: true
  
  attr_accessible :content, :team_id, :user_id
  
end
