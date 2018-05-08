class User < ApplicationRecord
  
  attr_accessor :login		
  has_many :created_events, :foreign_key => :creator_id, :class_name => 'Event'
  #has many created events. Created events est donc la foreign key creator_id qui se trouve dans la table Event
  has_and_belongs_to_many :attended_events, :class_name => 'Event', :join_table => :events_users
  #has_and_belongs_to_many :attended_events. Ma clé de liaison est la clé qui correspond à ma table 'Event' dans ma join_table (event_id).
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Z0-9 _\.]*\z/}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.find_first_by_auth_conditions(warden_conditions)
  	conditions = warden_conditions.dup
  	if login = conditions.delete(:login)
  	  where(conditions.to_hash).where("lower(name) = :value OR lower(email) = :value", value:login.downcase).first	
  	else  
  	  where(conditions.to_hash).first		
    end		
  end    
   

end
