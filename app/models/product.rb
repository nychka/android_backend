class Product < ActiveRecord::Base
  multilang :title
  belongs_to :group
end
