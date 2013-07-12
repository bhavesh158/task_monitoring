class User < ActiveRecord::Base
  
  has_and_belongs_to_many :teams, join_table: 'team_members'
  
  validates :first_name, :last_name, :address, :mobile_no, presence: true
  validates :first_name, length: { minimum: 2}
  validates :last_name, length: { minimum: 2}
  validates_each :first_name, :last_name do |record, attr, value| 
    record.errors.add( attr, 'Must start with upper case') if value =~ /\A[a-z]/
  end
  validates :mobile_no,numericality: { only_integers: true }, length: { is: 10}
  
  def display_name
    return self.first_name + " " + self.last_name
  end
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :address, :mobile_no
  
end
