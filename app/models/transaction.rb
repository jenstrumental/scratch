class Transaction < ActiveRecord::Base
	validates_presence_of :amount

	attr_accessible :amount
end
