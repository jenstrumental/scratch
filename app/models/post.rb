class Post < ActiveRecord::Base
  attr_accessible :author_id, :content, :deadline, :title
end
