class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:edit, :show, :update, :destroy]
  before_action :set_groups, only: [:new, :edit]

  def index
    @products = Product.all
  end
  def new
    @product = Product.new
  end
  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /steps/1
  # GET /steps/1.json
  def show
  end
   # GET /steps/1/edit
  def edit
  end
  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
    def available_locales
      [:en, :ua]
    end
    def set_groups
      @groups = Group.all.map {|item|[item.title.any, item.id]}
      @available_locales = available_locales
    end
    def product_params
      permitted = [:calories, :fats, :proteins, :carbohydrates, :image, :group_id]
      permitted.concat available_locales.map {|locale| "title_#{locale.to_s}".to_sym }
     
      params.require(:product).permit(permitted)
    end
end

