class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.integer :calories
      t.float :fats
      t.float :proteins
      t.float :carbohydrates
      t.string :image
      t.integer :group_id

      t.timestamps
    end
    add_index :products, :group_id
  end
end
