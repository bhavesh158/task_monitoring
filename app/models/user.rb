class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_and_belongs_to_many :teams, join_table: 'team_members'
  has_many :tasks
  has_many :task_comments
  has_many :feedbacks
  
  validates :first_name, :last_name, :address, :mobile_no, presence: true
  validates :first_name, length: { minimum: 2}
  validates :last_name, length: { minimum: 2}
  validates_each :first_name, :last_name do |record, attr, value| 
    record.errors.add( attr, 'Must start with upper case') if value =~ /\A[a-z]/
  end
  validates :mobile_no,numericality: { only_integers: true }, length: { is: 10}
  
  scope :get_user, lambda { |user_id| where(:id => user_id) }
  
  def get_current_user_type(team)
    @team = TeamMember.where(team_id: team.id)
    @team.where(user_id: id).first.user_type
  end
  
  def display_name
    return self.first_name + " " + self.last_name
  end
  
  
  devise :invitable, :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100" }, :default_url => "/home/rails/test123/task_monitoring/missing.png"
  attr_accessible :avatar, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :address, :mobile_no
  
end
