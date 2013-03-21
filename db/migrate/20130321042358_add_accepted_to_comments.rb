class AddAcceptedToComments < ActiveRecord::Migration
  def up
  	add_column :comments, :accepted, :boolean, :default => false
  end

  def down
  	remove_column :comments, :accepted
  end
end
