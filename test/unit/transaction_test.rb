require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
	test "a transaction may not be created without an amount" do
		t = Transaction.new
		assert !t.save, "saved a Transaction without an amount"
	end
	test "an adjustment may have a creditee if it has no debitee" do
		Adjustment.create!(creditee_id:users(:jen).id, 
			debitee_id:nil,
			amount:1)
	end
	test "an adjustment may have a debitee if it has no creditee" do
		Adjustment.create!(debitee_id:users(:jen).id, 
			creditee_id:nil,
			amount:1)
	end
	test "an adjustment may not have both a debitee and a creditee" do
		a = Adjustment.new(creditee_id:users(:jen).id, 
			debitee_id:users(:jen).id,
			amount:1)
		assert !a.save, "saved an Adjustment with both a creditee and debitee"
	end
	test "a transfer must have both a debitee and a creditee" do
		t = Transfer.new(amount:1)
		assert !t.save, "saved a transfer without both a creditee and a debitee"
	end
	test "a transfer can't be created if the debitee has NSF" do
		t = Transfer.new(amount:10,
			creditee_id:users(:jen).id, 
			debitee_id:users(:bob).id)
		assert !t.save, "saved a transfer even though debitee doesn't have enough money to cover it"
	end
	test "a transfer adjusts participants' balances by the appropriate amount" do
		a = rand(10)
		jen_balance_pre = users(:jen).balance
		bob_balance_pre = users(:bob).balance
		t = Transfer.create!(amount:a,
			creditee_id:users(:bob).id,
			debitee_id:users(:jen).id)
		assert users(:jen).reload.balance == jen_balance_pre - a, "transfer didn't take funds from debitee - #{jen_balance_pre} - #{a} !== #{users(:jen).balance}"
		assert users(:bob).reload.balance == bob_balance_pre + a, "transfer didn't give funds to creditee"
	end
end
