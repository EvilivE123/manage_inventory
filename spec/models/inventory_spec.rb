require 'rails_helper'

RSpec.describe Inventory, type: :model do

  subject { create(:inventory) }

  describe 'Associations' do
    it { should belong_to(:product) }
    it { should belong_to(:warehouse) }
  end

  describe 'Validations' do
    context 'when product_count is an integer' do
      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when product_count is a string' do
      before do
        subject.product_count = 'This is a string'
      end

      it 'is not valid' do
        expect(subject).not_to be_valid      
      end
    end

    context 'when product exceeds warehouse max_capacity' do      
      before do
        subject.warehouse.max_capacity = 1
        subject.warehouse.inventories << subject
        subject.warehouse.save
        @new_inventory = build(:inventory, product: create(:product), warehouse: subject.warehouse)
        @new_inventory.valid?       
      end

      it 'is not valid' do
        expect(@new_inventory).not_to be_valid
      end

      it 'shows error message' do
        expect(@new_inventory.errors.full_messages.first).to eq(
          "#{subject.warehouse.name}'s warehouse max capacity reached!")
      end
    end

    context 'when product does not exceeds warehouse max_capacity' do
      before do
        @new_inventory = build(:inventory, product: create(:product), warehouse: subject.warehouse)
        @new_inventory.valid?       
      end

      it 'is valid' do
        expect(@new_inventory).to be_valid
      end
    end
  end
end
