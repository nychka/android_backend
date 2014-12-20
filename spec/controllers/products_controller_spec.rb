require 'rails_helper'

describe ProductsController, :type => :controller do
  before(:each) { login_user }
   
  it "GET /products" do
    get :index
    expect(response.status).to eq 200
  end
  it "GET /products/new" do
    get :new
    expect(response.status).to eq 200
  end
  it "POST /products" do
    expect{ post :create, product: attributes_for(:product) }.to change(Product, :count).by(1)
  end
  it "POST /products redirects to last product" do
    post :create, product: attributes_for(:product)
    expect(response).to redirect_to Product.last
  end
  it "GET /products/:id" do
    product = create(:product)
    get :show, id: product
    expect(response.status).to eq 200
  end
  it "GET /products/:id/edit" do
    product = create(:product)
    get :edit, id: product
    expect(response.status).to eq 200
  end
  it "PATCH /products/:id" do
    product = create(:product)
    updated_product = attributes_for(:product)
    updated_product[:title_en] = 'orange'
    patch :update, id: product, product: updated_product
    expect(response).to redirect_to product
  end
  it "PUT /products/:id" do
    product = create(:product)
    updated_product = attributes_for(:product)
    updated_product[:title_en] = 'orange'
    put :update, id: product, product: updated_product
    expect(response).to redirect_to product
  end
  it "DELETE /products/:id" do
     product = create(:product)
     expect{delete :destroy, id: product}.to change(Product, :count).by(-1)
     expect(response).to redirect_to products_path
  end
end