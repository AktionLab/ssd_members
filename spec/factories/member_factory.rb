FactoryGirl.define do
  sequence :email do |n|
    "test-#{n}@example.com"
  end

  factory :member do
    account_category Member::ACCOUNT_CATEGORIES.first
    email { Factory.next(:email) }
    name "Test Member"
  end
end
