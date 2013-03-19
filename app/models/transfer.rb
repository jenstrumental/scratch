class Transfer < Transaction
  validates_presence_of :creditee_id, :debitee_id
  validate :check_debitee_funds

  belongs_to :creditee, :class_name => "User"
  belongs_to :debitee, :class_name => "User"

  attr_accessible :creditee_id, :debitee_id

  before_create :transfer_scratch

  def check_debitee_funds
  	if debitee && (debitee.balance < amount)
  		errors.add(:amount, "debitee has insufficient funds to cover amount")
  	end
  end

  def transfer_scratch
  	ActiveRecord::Base.transaction do
  		debitee.debit(amount)
  		creditee.credit(amount)
  	end
  end

end