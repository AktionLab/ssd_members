FactoryGirl.define do
  factory :payment do
    amount "9.99"
    source { Factory(:member) }
  end
end
