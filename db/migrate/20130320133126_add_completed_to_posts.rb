class AddCompletedToPosts < ActiveRecord::Migration
  def up
  	add_column :posts, :completed, :boolean, :default => false
  end

  def down
  	remove_column :posts, :completed
  end
end
