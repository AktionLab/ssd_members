class DuePayment < ActiveRecord::Base
  belongs_to :admin_user
  belongs_to :due
end
