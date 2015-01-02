class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :show, :update, :destroy]
  before_action :set_groups, only: [:new, :edit]

  def index
    @products = current_user ? Product.system_with_owner(current_user.id) : Product.system
    respond_to do |format|
      unless @response.has_key? :errors
        format.html { render :index }
        format.json { render json: @products, each_serializer: get_serializer_for(:product) }
      else 
        @response[:status] = :unprocessable_entity
        format.html { render :index, notice: 'Something nasty happened...'}
        format.json { render json: @response, status: @response[:status] }
      end
    end
  end
  def new
    @product = Product.new
  end
  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save and current_user.products << @product
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        @response[:status] = :unprocessable_entity
        @response[:errors] = @products.errors
        format.html { render :new }
        format.json { render json: @response, status: @response[:status] }
      end
    end
  end
  # GET /steps/1
  # GET /steps/1.json
  def show
    respond_to do |format|
      format.html {render :show, location: @product}
      format.json {render json: @product, serializer: get_serializer_for(:product)}
    end
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
    def set_groups
      @groups = Group.all.map {|item|[item.title.any, item.id]}
    end
    def product_params
      permitted = [:calories, :fats, :proteins, :carbohydrates, :image, :group_id]
      permitted.concat available_locales.map {|locale| "title_#{locale.to_s}".to_sym }
     
      params.require(:product).permit(permitted)
    end
end

