class Permition < ActiveRecord::base
  belongs_to :user
  belongs_to :role
end

