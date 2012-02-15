class Charge < ActiveRecord::Base
  belongs_to :chargeable, :polymorphic => true

  before_update :prevent_update
  after_create :debit_chargeable
  after_destroy :credit_chargeable

  validates :amount, :presence => true, :numericality => true
  validates :chargeable, :presence => true
  validate :positive_amount, :on => :create

private

  def positive_amount
    errors.add(:amount, "must be positive") unless amount && amount > 0
  end

  def prevent_update
    errors.add(:amount, "can't be modified")
    return false
  end

  def debit_chargeable
    chargeable.debit(amount)
  end

  def credit_chargeable
    chargeable.credit(amount)
  end
end
