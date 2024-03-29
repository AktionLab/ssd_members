class Payment < ActiveRecord::Base
  belongs_to :payable, :polymorphic => true

  before_update :prevent_update
  after_create :credit_payable
  after_destroy :debit_payable

  validates :amount, :presence => true, :numericality => true
  validates :payable, :presence => true
  validate :positive_amount, :on => :create

private

  def positive_amount
    errors.add(:amount, "must be positive") unless amount && amount > 0
  end

  def prevent_update
    errors.add(:amount, "can't be modified")
    return false
  end
  
  def credit_payable
    payable.credit(amount)
  end

  def debit_payable
    payable.debit(amount)
  end
end
