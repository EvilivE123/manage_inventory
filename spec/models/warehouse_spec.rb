require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  subject { build(:warehouse) }

  describe 'Associations' do
    it { should have_many(:inventories) }
    it { should have_many(:products) }
    it { should have_many(:products).through(:inventories) }
  end

  describe 'Validations' do
    context 'when validating presence of name' do
      context 'when name is not present' do
        before do
          subject.name = nil
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end

      context 'when name is present' do
        it 'is valid' do
          expect(subject).to be_valid
        end        
      end
    end

    context 'when validating presence of pin code' do
      context 'when pin code is not present' do
        before do
          subject.pincode = nil
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end

      context 'when pin code is present' do
        it 'is valid' do
          expect(subject).to be_valid
        end        
      end
    end

    context 'when validating presence of max capacity' do
      context 'when max capacity is not present' do
        before do
          subject.max_capacity = nil
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end
      end

      context 'when max capacity is present' do
        it 'is valid' do
          expect(subject).to be_valid
        end        
      end      
    end


    context 'when validating length of pin code' do
      context 'when length of pin code is less than 6' do
        before do
          subject.pincode = 123
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end        
      end

      context 'when length of pin code is more than 6' do
        before do
          subject.pincode = 12353242342
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end        
      end

      context 'when length of pin code is 6' do
        it 'is valid' do
          expect(subject).to be_valid
        end
      end
    end

    context 'when validating numericality of pin code' do
      context 'when pin code value is a string' do
        before do
          subject.pincode = 'pincode'
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end        
      end

      context 'when pin code value is an integer' do
        it 'is valid' do
          expect(subject).to be_valid
        end
      end
    end

    context 'when validating numericality of max capacity' do
      context 'when max capacity value is a string' do
        before do
          subject.max_capacity = 'max_capacity'
        end

        it 'is not valid' do
          expect(subject).not_to be_valid
        end        
      end

      context 'when max capacity value is an integer' do
        it 'is valid' do
          expect(subject).to be_valid
        end
      end      
    end
  end

  describe 'InstanceMethod' do
    context 'when warehouse needs total item count' do
      it 'should not return string' do
        expect(subject.item_count).not_to be_a String
      end

      it 'should not return integer' do
        expect(subject.item_count).to be_a Integer
      end

      it 'should return value' do
        expect(subject.item_count).to be_present
      end

      it 'should be greater than or equal to 0' do
        expect(subject.item_count).to be >= 0
      end
    end
  end
end
