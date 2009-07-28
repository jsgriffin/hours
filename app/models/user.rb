class User < ActiveRecord::Base
	validates_presence_of :name, :email, :password
	has_many :clients
	has_many :feedbacks
end
