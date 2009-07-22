class Client < ActiveRecord::Base
	belongs_to :user
	has_many :expenses, :order=>'created_at DESC'
	has_many :intervals, :order=>'created_at DESC'
	attr_accessor :combined
end
