class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :role

      t.timestamps
    end
  end
  def self.down
    remove_table :roles
  end
end
