class Task < ActiveRecord::Base
  has_many :task_comments
  belongs_to :team
  belongs_to :user
  before_create do |task|
    task.status = "Pending"
  end
  
  validates :title, presence: true
  validates :details, presence: true
  
  attr_accessible :details, :status, :team_id, :title, :user_id
end
