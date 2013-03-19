class Adjustment < Transaction
	validate :check_user_association

	attr_accessible :debitee_id, :creditee_id

	def check_user_association
		if debitee_id
			if creditee_id
				errors.add(:debitee_id, "can't have both a creditee_id and a debitee_id")
			end
		else
			if creditee_id.nil?
				errors.add(:debitee_id, "must have either a creditee_id or a debitee_id")
			end
		end
	end
end