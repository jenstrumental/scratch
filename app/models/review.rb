class Review < ActiveRecord::Base
  attr_accessible :comment, :comment_id, :reviewer_id, :score
  validates_presence_of :comment_id, :reviewer_id, :score
  validates_inclusion_of :score, :in => 0..5
end
