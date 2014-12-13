class ChangeGroupsTitleToHstore < ActiveRecord::Migration
  def self.up
    change_column :groups, :title, 'hstore USING CAST(title AS hstore)'
  end
  def self.down
    change_column :groups, :title, 'string USING CAST(title AS string)'
  end
end
