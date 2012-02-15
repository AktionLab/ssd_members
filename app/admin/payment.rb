ActiveAdmin.register Payment do
  filter :none

  index do
    column :payable do |payment|
      link_to payment.payable.name, admin_member_path(payment.payable)
    end
    column :amount do |payment|
      number_to_currency payment.amount
    end
    default_actions
  end

  show do
    panel "Payment Details - #{payment.id}" do
      attributes_table_for payment do
        row("Member") { payment.payable.name }
        row("Amount") { number_to_currency payment.amount }
      end
    end
  end

  form do |f|
    f.inputs "Payment Details" do
      f.input :payable_type, :as => :hidden, :value => 'Member'
      f.input :payable_id, :as => :select, :collection => Member.all.reduce({}) {|c,m| c.merge({m.name => m.id})}
      f.input :amount
    end
    f.buttons
  end
end
