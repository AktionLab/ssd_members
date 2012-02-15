models = %w(AdminUser Member Charge Payment).map(&:constantize)
models.each(&:delete_all)

AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

members = (1..3).map do |n|
  Member.create!({
    :name => "Test User #{n}",
    :email => "test-#{n}@example.com",
    :address => "123 45th St",
    :phone => "555 555 5555",
    :account_balance => n*100,
    :account_category => Member::ACCOUNT_CATEGORIES.first
  })
end

members.each do |member|
  (1..3).each do |n|
    member.payments.create(:amount => n*10)
    member.charges.create(:amount => n*20)
  end
end
