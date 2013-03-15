class AddProviderUidAndNameToUsers < ActiveRecord::Migration
  def up
  	 add_column :users, :provider, :string
     add_column :users, :uid, :integer, :default => 0
     add_column :users, :name, :string
  end

  def down
	 remove_column :users, :provider
     remove_column :users, :uid
     remove_column :users, :name
  end
end
