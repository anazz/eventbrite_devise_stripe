class Event < ApplicationRecord
	has_and_belongs_to_many :user_attendees, :class_name => 'User', :join_table => :events_users
	#La valeur de user attendees correspond à la valeur de :events_users (qui relie ma table users) dans ma join table event_user.
	belongs_to :creator, :class_name => 'User'
	#mon event belongs_to un seul creator (foreign key de ma table events) qui est lié à mon id_user de ma table users.
end
