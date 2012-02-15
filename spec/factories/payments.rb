FactoryGirl.define do
  factory :payment do
    amount "9.99"
    payable { Factory(:member) }
  end
end
