require 'spec_helper'

describe Member do
  describe 'factories' do
    it 'should have valid factories' do
      Factory.build(:member).should be_valid
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:account_category) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }

    context 'uniqueness' do
      before(:each) { Factory(:member) }
      it { should validate_uniqueness_of(:email) }
    end
  end

  describe 'associations' do
    it { should have_many(:payments) }
  end

  describe 'account_balance' do
    context 'new members' do
      it 'should have a balance of zero' do
        Factory(:member).account_balance.should == 0
      end

      it 'should use a specified account balance if given' do
        Factory(:member, :account_balance => 50).account_balance.to_f.should == 50.0
      end
    end

    describe 'credit_available' do
      it 'should be true if the amount is available' do
        member = Factory(:member, :account_balance => 199.99)
        member.should have_available_credit(199.99)
      end

      it 'should be false if the amount is not available' do
        member = Factory(:member, :account_balance => 199.99)
        member.should_not have_available_credit(200.00)
      end
    end

    describe 'credit' do
      it 'should increase the account balance' do
        member = Factory(:member, :account_balance => 200)
        member.credit(99)
        member.reload.account_balance.to_f.should == 299.0
      end
    end

    describe 'debit' do
      it 'should decrease the account balance' do
        member = Factory(:member, :account_balance => 200)
        member.debit(35)
        member.reload.account_balance.to_f.should == 165.0
      end

      context 'when not enough credit is available' do
        it 'should raise a NotEnoughCreditException' do
          member = Factory(:member, :account_balance => 5)
          lambda {
            member.debit(10)
          }.should raise_error
        end

        it 'should not change the account balance if there is no credit available' do
          member = Factory(:member, :account_balance => 5)
          begin
            member.debit(10)
          rescue NotEnoughCreditException
          end
          member.reload.account_balance.to_f.should == 5.0
        end
      end
    end
  end
end
