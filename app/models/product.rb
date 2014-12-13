class Product < ActiveRecord::Base
  #serialize :title, ActiveRecord::Coders::Hstore
  multilang :title
  belongs_to :group
end
