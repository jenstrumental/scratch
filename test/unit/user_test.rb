require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can't have a negative balance" do
  	j = users(:jen)
  	j.balance = -1
  	assert !j.save, "managed to save a user with a negative balance"
  end
end
