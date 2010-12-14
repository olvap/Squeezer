class Blog < ActiveRecord::Base
  attr_accessible :title, :body, :user_id
  belongs_to :user
  has_one :comment, :as=>:commentable,:dependent => :destroy
    
end
