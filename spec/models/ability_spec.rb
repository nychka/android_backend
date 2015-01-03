require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, :type => :model do
  context "user's abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ FactoryGirl.create(:user) }

    context "/products" do
      it "can read products" do
        expect(ability).to be_able_to(:read, Product.new)
      end
      it "can create products" do
        expect(ability).to be_able_to(:create, Product)
      end
      it "cannot update products" do
        expect(ability).not_to be_able_to(:update, Product.new)
      end
      it "can update only its own products" do
        expect(ability).to be_able_to(:update, Product.new(user_id: user.id))
      end
      it "cannot destroy products" do
        expect(ability).not_to be_able_to(:destroy, Product.new)
      end
      it "can destroy only its own products" do
        expect(ability).to be_able_to(:destroy, Product.new(user_id: user.id))
      end
    end

    context "/groups" do
      it "can read groups" do
        expect(ability).to be_able_to(:read, Group.new)
      end
      it "can create groups" do
        expect(ability).not_to be_able_to(:create, Group)
      end
      it "cannot update groups" do
        expect(ability).not_to be_able_to(:update, Group.new)
      end
      it "cannot destroy groups" do
        expect(ability).not_to be_able_to(:destroy, Group.new)
      end
    end
  end

  context "manager's abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ FactoryGirl.create(:manager) }

    context "/products" do
      it "can read products" do
        expect(ability).to be_able_to(:read, Product.new)
      end
      it "can create products" do
        expect(ability).to be_able_to(:create, Product)
      end
      it "can update products" do
        expect(ability).to be_able_to(:update, Product.new)
      end
      it "can destroy products" do
        expect(ability).to be_able_to(:destroy, Product.new)
      end
    end

    context "/groups" do
      it "can read groups" do
        expect(ability).to be_able_to(:read, Group.new)
      end
      it "can create groups" do
        expect(ability).to be_able_to(:create, Group)
      end
      it "can update groups" do
        expect(ability).to be_able_to(:update, Group.new)
      end
      it "can destroy groups" do
        expect(ability).to be_able_to(:destroy, Group.new)
      end
    end
  end
end
