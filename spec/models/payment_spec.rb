require 'spec_helper'

describe Payment do
  describe 'factories' do
    it 'should have valid factories' do
      Factory.build(:payment).should be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:source) }
    it { should validate_numericality_of(:amount) }
  end
  
  describe 'associations' do
    it { should belong_to(:source) }
  end

  describe 'create' do
    it 'should increase the sources account balance' do
      member = Factory(:member, :account_balance => 50)
      Factory(:payment, :amount => 20, :source => member)
      member.reload.account_balance.to_f.should == 70.0
    end
  end
end
