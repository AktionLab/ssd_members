class Payment < ActiveRecord::Base
  belongs_to :source, :polymorphic => true

  after_create :credit_source_balance

  validates :amount, :presence => true, :numericality => true
  validates :source, :presence => true

private
  
  def credit_source_balance
    source.credit(amount)
  end
end
