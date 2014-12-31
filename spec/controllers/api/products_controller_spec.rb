require 'rails_helper'

describe ProductsController, type: :controller do
  context "API for unauthorized user" do
    context "GET /products" do
      before(:each) do
        @products, @product_count = [], 3
        @product_count.times do
          product = FactoryGirl.create(:product)
          @products << product.as_json.delete_if{|k,v|k == 'created_at' || k == 'updated_at'}
        end
      end
      it "fails to create product as unauthorized user" do
        product = FactoryGirl.build(:product)
        post :create, { format: :json, product: product }
        data = JSON.parse(response.body)
        expect(response.status).to eq 401
        expect(data['error']).to match 'You need to sign in or sign up before continuing.'
      end
      it "gets a list of products" do
        get :index, format: :json
        expect(response.status).to eq 200
        data = JSON.parse(response.body)
        expect(data).to be_a_kind_of Array
        expect(data.length).to eq @product_count
        expect(data).to eq @products
      end
    end
  end
  context "API for authorized user" do
  end
end