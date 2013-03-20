class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.text :content
      t.datetime :deadline

      t.timestamps
    end
  end
end
