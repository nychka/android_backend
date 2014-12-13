class ProductsController < InheritedResources::Base

  private

    def product_params
      params.require(:product).permit(:title, :calories, :fats, :proteins, :carbohydrates, :image)
    end
end

