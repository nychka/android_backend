class ChangeAuthTokenInUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :auth_token, :authentication_token
  end
  def self.down
   rename_column :users, :authentication_token, :auth_token
  end
end
