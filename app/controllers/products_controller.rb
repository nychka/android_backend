class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  private

    def product_params
      params.require(:product).permit(:title, :calories, :fats, :proteins, :carbohydrates, :image)
    end
end

