class Post < ActiveRecord::Base
  acts_as_commentable
  
  attr_accessible :author_id, :content, :deadline, :title, :bounty

  validates_presence_of :author_id, :content, :title, :bounty

  before_save :set_default_deadline

  belongs_to :author, :class_name => "User"

  DEFAULT_TIME_SPAN = 1.week

  def set_default_deadline
  	if self.deadline.nil?
      self.deadline = Time.now + 1.week
    end
  end

end
