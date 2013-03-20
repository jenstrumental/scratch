class AddBountyToPosts < ActiveRecord::Migration
  def change
  	change_table :posts do |t|
  		t.integer :bounty
  	end
  end
end
