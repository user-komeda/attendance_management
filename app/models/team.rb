# Team
class Team < ApplicationRecord
  has_many :users, dependent: :destroy
end