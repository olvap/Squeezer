class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic =>true
  has_many :posts,:dependent => :destroy
end