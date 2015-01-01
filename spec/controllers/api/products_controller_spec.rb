require 'rails_helper'

describe ProductsController, type: :controller do
  context "API" do
    context "GET /products" do
      before(:each) do
        products, @product_count = [], 3
        @product_count.times { products << FactoryGirl.create(:system_product) }
        @products = format_data(products)
      end
      context "common" do
        it "gets status 200" do
          get :index, format: :json
          expect(response.status).to eq 200
        end
        it "includes group" do
          group = FactoryGirl.create(:group)
          products = [FactoryGirl.create(:system_product,group_id: group.id)]
          items = format_data(products).concat(@products)
          get :index, {format: :json, include: 'group'}
          data = JSON.parse(response.body)
          group_item = data[0]['group']
          expect(format_item(group_item)).to eq format_item(group)
        end
      end
      context "unauthorized request" do
        it "gets a list of system products" do
          get :index, format: :json
          data = JSON.parse(response.body)
          expect(data).to be_a_kind_of Array
          expect(data.length).to eq @product_count
          expect(data).to eq @products
        end
        it "gets ONLY a list of system products" do
          FactoryGirl.create_list(:product, 3)
          get :index, format: :json
          data = JSON.parse(response.body)
          expect(Product.count).to eq 6
          expect(data).to eq @products
        end
      end
      context "authorized request" do
        it "gets a list of products together with system" do
          user = login_user
          user_products = FactoryGirl.create_list(:product, 3, user_id: user.id)
          items = format_data(user_products).concat(@products)
          get :index, format: :json
          data = JSON.parse(response.body)
          expect(Product.count).to eq 6
          expect(data).to eq items
        end
      end
    end
    context "POST /products" do
      context "unauthorized request" do
        it "fails to create product" do
          product = FactoryGirl.build(:product)
          post :create, { format: :json, product: product }
          data = JSON.parse(response.body)
          expect(response.status).to eq 401
          expect(data['error']).to match 'You need to sign in or sign up before continuing.'
        end
      end
    end
  end
end