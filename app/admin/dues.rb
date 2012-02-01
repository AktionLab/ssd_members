ActiveAdmin.register Due do
  index do
    column :date
    column :business_rate
    column :regular_rate
    column :student_rate
  end
end
