class AddIndexToGroupsTitle < ActiveRecord::Migration
  def up
    add_index :groups, [:title], name: "groups_gist_title", using: :gist
  end

  def down
    remove_index :groups, name: "groups_gist_title"
  end
end
