class Forum < ActiveRecord::Base
  attr_accessible :name, :desc
  
  has_many :topics
end
