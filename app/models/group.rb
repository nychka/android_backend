class Group < ActiveRecord::Base
  #serialize :title, ActiveRecord::Coders::Hstore
  multilang :title
  has_many :products
end
