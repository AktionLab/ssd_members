# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :charge do
    amount "9.99"
    chargeable { Factory(:member) }
  end
end
