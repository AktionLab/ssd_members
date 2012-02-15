class Member < ActiveRecord::Base
  ACCOUNT_CATEGORIES = %w(student regular business)

  before_validation :zero_account_balance, :if => :new_record?

  has_many :payments, :as => :payable
  has_many :charges, :as => :chargeable

  validates :account_category, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence => true

  def has_available_credit?(amount)
    self.account_balance >= amount
  end

  def credit(amount)
    self.update_attribute(:account_balance, self.account_balance + amount)
  end

  def debit(amount)
    if has_available_credit? amount
      self.update_attribute(:account_balance, self.account_balance - amount)
    else
      raise NotEnoughCreditException.new("Debit of #{amount} requested with only #{self.account_balance} available.")
    end
  end

private

  def zero_account_balance
    self.account_balance = 0.0 if self.account_balance.nil?
  end
end

class NotEnoughCreditException < Exception; end
