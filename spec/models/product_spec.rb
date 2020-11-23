require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { 
    build(:product)
  }

  describe 'Associations' do
    it { should have_many(:warehouses) }
    it { should have_many(:inventories) }
    it { should have_many(:inventories).dependent(:destroy) }
    it { should have_many(:warehouses).through(:inventories) }
  end

  describe 'Validations' do

    context 'when validating name' do
      context 'when name is present' do
        it 'is valid' do
          expect(subject).to be_valid
        end
      end

      context 'when name is not present' do
        before do
          subject.name = nil
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end
    end

    context 'when validating price' do
      context 'when price is present' do
        it 'is valid' do
          expect(subject).to be_valid
        end
      end

      context 'when price is not present' do
        before do
          subject.price = nil
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end

      context 'when price is a string' do
        before do 
          subject.price = 'Rupee'
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end

      context 'when price is a number' do
        it 'is valid' do
          expect(subject).to be_valid
        end
      end
    end
  end
end
