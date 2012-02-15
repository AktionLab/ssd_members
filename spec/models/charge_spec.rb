require 'spec_helper'

describe Charge do
  let(:member) { Factory(:member, :account_balance => 50) }
  let(:charge) { Factory(:charge, :amount => 20, :chargeable => member) }

  describe 'factories' do
    it 'should have valid factories' do
      Factory.build(:charge).should be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:chargeable) }
    it { should validate_numericality_of(:amount) }

    it 'should not allow negative amounts' do
      charge = Factory.build(:charge, :amount => -1)
      charge.should_not be_valid
      charge.errors.messages[:amount].should == ["must be positive"]
    end
  end

  describe 'associations' do
    it { should belong_to(:chargeable) }
  end
    
  describe 'create' do
    it 'should decrease the sources account balance' do
      Factory(:charge, :amount => 20, :chargeable => member)
      member.reload.account_balance.to_f.should == 30.0
    end
  end

  describe 'destroy' do
    it 'should increase the sources account balance' do
      charge = Factory(:charge, :amount => 20, :chargeable => member)
      charge.destroy
      member.reload.account_balance.to_f.should == 50.0
    end
  end

  describe 'update' do
    it 'should not modify the charge' do
      charge.update_attributes(:amount => 30)
      charge.reload.amount.to_f.should == 20.0
    end

    it 'should not modify the source balance' do
      charge.update_attributes(:amount => 30)
      member.reload.account_balance.to_f.should == 30.0
    end

    it 'should add an error' do
      charge.update_attributes(:amount => 30)
      charge.errors.messages[:amount].should == ["can't be modified"]
    end
  end
end
