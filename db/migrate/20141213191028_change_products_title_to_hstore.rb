class ChangeProductsTitleToHstore < ActiveRecord::Migration
  def self.up
    change_column :products, :title, 'hstore USING CAST(title AS hstore)'
  end
  def self.down
    change_column :products, :title, 'string USING CAST(title AS string)'
  end
end
