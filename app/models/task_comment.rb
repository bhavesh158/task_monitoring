class TaskComment < ActiveRecord::Base
   
  validates :message, presence: true
  
  belongs_to :users
  belongs_to :tasks
  has_attached_file :comment_attachment
  attr_accessible :comment_attachment, :message, :task_id, :user_id
end
