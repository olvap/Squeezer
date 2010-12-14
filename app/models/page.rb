class Page < ActiveRecord::Base
  attr_accessible :title, :menu, :body, :user_id
end
