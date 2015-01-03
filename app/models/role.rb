class Role < ActiveRecord::Base
  has_many :users
  validates :role, presence: true
end
