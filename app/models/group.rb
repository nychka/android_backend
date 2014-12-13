class Group < ActiveRecord::Base
  multilang :title
  has_many :products
end
