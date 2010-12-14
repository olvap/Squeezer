class Topic < ActiveRecord::Base
  validates_presence_of :title,:forum_id 
  attr_accessible :title, :forum_id
  has_one :comment, :as=>:commentable,:dependent => :destroy
  belongs_to :forum
end
