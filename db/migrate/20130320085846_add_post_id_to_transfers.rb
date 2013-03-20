class AddPostIdToTransfers < ActiveRecord::Migration
  def change
  	change_table :transactions do |t|
  		t.integer :post_id
  	end
  end
end
