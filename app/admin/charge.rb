ActiveAdmin.register Charge do
  filter :none

  index do
    column :chargeable do |charge|
      link_to charge.chargeable.name, admin_member_path(charge.chargeable)
    end
    column :amount do |charge|
      number_to_currency charge.amount
    end
    default_actions
  end

  show do
    panel "Charge Details - #{charge.id}" do
      attributes_table_for charge do
        row("Member") { charge.chargeable.name }
        row("Amount") { number_to_currency charge.amount }
      end
    end
  end

  form do |f|
    f.inputs "Charge Details" do
      f.input :chargeable_type, :as => :hidden, :value => 'Member'
      f.input :chargeable_id, :as => :select, :collection => Member.all.reduce({}) {|c,m| c.merge({m.name => m.id})}
      f.input :amount
    end
    f.buttons
  end
end
