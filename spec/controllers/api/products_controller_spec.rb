require 'rails_helper'

describe ProductsController, type: :controller do
  context "API" do
    context "GET /products" do
      before(:each) do
        @products, @product_count = [], 3
        @product_count.times do
         @products << ProductSerializer.new(FactoryGirl.create(:system_product)).attributes.stringify_keys
        end
      end
      context "common" do
        it "gets status 200" do
          get :index, format: :json
          expect(response.status).to eq 200
        end
        it "includes group" do
          group = FactoryGirl.create(:group)
          products = [FactoryGirl.create(:system_product,group_id: group.id)]
          get :index, {format: :json, include: 'group'}
          data = JSON.parse(response.body)
          group_item = data[0]['group']
          expect(group_item['id']).to eq group.id
        end
        it "shows attribute :owner in reponse" do
          user = login_user(:user)
          products = FactoryGirl.create_list(:product, 2, user_id: user.id)
          get :index, format: :json
          data = JSON.parse(response.body)
          expect(data.first['owner']).to be true
          expect(data.last['owner']).to be false
        end
      end
      context "localization" do
        before(:each) do
          FactoryGirl.create(:system_product, title_en: 'apple', title_ua: 'яблуко')
        end
        it "gets english localization for product" do
          get :index, format: :json, lang: :en
          data = JSON.parse(response.body)
          expect(data.count).to eq 4
          expect(data.first['title']).to eq 'apple'
        end
        it "gets ukrainian localization for product" do
          get :index, format: :json, lang: :ua
          data = JSON.parse(response.body)
          expect(data.first['title']).to eq 'яблуко'
        end
        it "gets default localization for product" do
          get :index, format: :json, lang: :fr
          data = JSON.parse(response.body)
          expect(data.first['title']).to eq 'apple'
        end
        xit "gets unprocessible localization for product" do
          get :index, format: :json, lang: :zz
          data = JSON.parse(response.body)
          expect(response.status).to eq 422
          expect(data['errors'][0]).to match 'is not a valid locale'
        end
      end
      context "unauthorized request" do
        it "gets a list of system products" do
          get :index, format: :json
          data = JSON.parse(response.body)
          expect(data).to be_a_kind_of Array
          expect(data.length).to eq @product_count
          expect(data).to match_array @products
        end
        it "gets ONLY a list of system products" do
          FactoryGirl.create_list(:product, 3)
          get :index, format: :json
          data = JSON.parse(response.body)
          expect(Product.count).to eq 6
          expect(data).to match_array @products
        end
      end
      context "authorized request" do
        it "gets a list of products together with system" do
          user = login_user(:user)
          user_products = FactoryGirl.create_list(:product, 3, user_id: user.id).map do |product|
            ProductSerializer.new(product).attributes.stringify_keys
          end
          items = user_products.concat(@products)
          get :index, format: :json
          data = JSON.parse(response.body)
          expect(Product.count).to eq 6
          expect(data).to match_array items
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
      context "authorized request" do
        it "creates product" do
          user = login_user(:user)
          product = FactoryGirl.attributes_for(:product, user_id: user.id)
          expect{ post :create, {format: :json, product: product} }.to change(Product, :count).by(1)
          expect(response.status).to eq 201
          expect(Product.last.user_id).to eq user.id
        end
      end
    end
  end
end