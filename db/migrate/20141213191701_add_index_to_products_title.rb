class AddIndexToProductsTitle < ActiveRecord::Migration
   def up
    add_index :products, [:title], name: "products_gist_title", using: :gist
  end

  def down
    remove_index :products, name: "products_gist_title"
  end
end
