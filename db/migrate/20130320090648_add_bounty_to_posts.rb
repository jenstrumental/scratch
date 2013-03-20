class AddBountyToPosts < ActiveRecord::Migration
  def up
  	change_table :posts do |t|
  		t.integer :bounty
  	end
  end

  def down
    remove_column :posts, :bounty
  end
end
