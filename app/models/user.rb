class User < ActiveRecord::Base
	validates_presence_of :name, :email, :password
	before_save :encode_password
	has_many :clients
	
	def encode_password
		self.password = Digest::MD5.hexdigest( self.password )
	end
end
