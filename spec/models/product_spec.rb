require 'rails_helper'

describe Product, type: :model do
  context "valid factories" do
    it "has valid factory :product" do
      expect(FactoryGirl.build(:product)).to be_valid
    end
    it "has valid factory :system_product" do
      expect(FactoryGirl.build(:system_product)).to be_valid
    end
  end
  context "invalid factories" do
    it "has empty title" do
      product = FactoryGirl.build(:product, title_en: '')
      expect(product).not_to be_valid
    end
    it "has non-string title" do
      product = FactoryGirl.build(:product, title_en: '12345')
      expect(product).not_to be_valid
    end
    it "has very short title" do
       product = FactoryGirl.build(:product, title_en: 'o')
      expect(product).not_to be_valid
    end
    it "doesn't belongs to user" do
      product = FactoryGirl.build(:product, user_id: nil)
      expect(product).not_to be_valid
    end
  end
  context "search" do
    it "searches :apple - result is not empty" do
      product = FactoryGirl.create(:product, title_en: 'apple')
      expect(Product.search("apple")).not_to be_empty
    end
     it "searches :apple - found" do
      product = FactoryGirl.create(:product, title_en: 'apple')
      expect(Product.search("apple").first).to eq product
    end
    it "empty search" do
      products = FactoryGirl.create_list(:product, 5)
      expect(Product.search("").count).to eq products.count
      expect(Product.search("")).to match_array products
    end
    it "searches :яблуко" do
      product = FactoryGirl.create(:product, title_en: 'apple', title_ua: 'яблуко')
      expect(Product.search("яблуко").first).to eq product
    end
    it "searches :foo and founds 3 results" do
      search_results = ['fooagra', 'abfoonal', 'zigerfoo']
      products = search_results.map { |title| FactoryGirl.create(:product, title_en: title) } 
      expect(Product.search("foo")).to match_array products
    end
  end 
end