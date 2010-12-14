class Post < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  
  validates_presence_of :body
  validates_presence_of :name, :if => :user?

  def user?
    !user
  end
  
end