class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :comment_id
      t.integer :reviewer_id
      t.integer :score
      t.text :comment

      t.timestamps
    end
  end
end
