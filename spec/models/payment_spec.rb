require 'spec_helper'

describe Payment do
  let(:member) { Factory(:member, :account_balance => 50) }
  let(:payment) { Factory(:payment, :amount => 20, :payable => member) }

  describe 'factories' do
    it 'should have valid factories' do
      Factory.build(:payment).should be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:payable) }
    it { should validate_numericality_of(:amount) }

    it 'should not allow negative amounts' do
      payment = Factory.build(:payment, :amount => -1)
      payment.should_not be_valid
      payment.errors.messages[:amount].should == ["must be positive"]
    end
  end
  
  describe 'associations' do
    it { should belong_to(:payable) }
  end

  describe 'create' do
    it 'should increase the sources account balance' do
      Factory(:payment, :amount => 20, :payable => member)
      member.reload.account_balance.to_f.should == 70.0
    end
  end

  describe 'destroy' do
    it 'should decrease the sources account balance' do
      payment = Factory(:payment, :amount => 20, :payable => member)
      payment.destroy
      member.reload.account_balance.to_f.should == 50.0
    end
  end

  describe 'update' do
    it 'should not modify the charge' do
      payment.update_attributes(:amount => 30)
      payment.reload.amount.to_f.should == 20.0
    end

    it 'should not modify the charge' do
      payment.update_attributes(:amount => 30)
      member.reload.account_balance.to_f.should == 70.0
    end

    it 'should add an error' do
      payment.update_attributes(:amount => 30)
      payment.errors.messages[:amount].should == ["can't be modified"]
    end
  end
end
