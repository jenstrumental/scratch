class AddBalanceColumnToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :balance, :integer, :default => 0
  end

  def down
  	remove_column :users, :balance
  end
end
