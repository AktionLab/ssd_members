ActiveAdmin.register Member do
  filter :name
  filter :email

  index do
    column :name do |member|
      link_to member.name, admin_member_path(member)
    end
    column :email
    column :account_balance
  end

  show do
    panel "Member Details - #{member.name}" do
      attributes_table_for member do
        row("Name") { member.name }
        row("Email") { member.email }
        row("Address") { member.address }
        row("Phone") { member.phone }
        row("Account Balance") { number_to_currency member.account_balance }
      end
    end

    panel "Transaction Details" do
      transactions = [member.payments, member.charges].flatten
      transactions = transactions.sort {|a,b| a.created_at <=> b.created_at}
      table :class => 'transactions', :style => 'width: 50%' do
        thead do
          tr do
            th(:class => 'date') { "Date" }
            th(:class => 'credit') { "Credit" }
            th(:class => 'debit') { "Debit" }
          end
        end
        tbody do
          transactions.each do |t|
            tr(:class => t.class.to_s.underscore) do
              td(:class => 'date') { t.created_at.strftime('%D') }
              td(:class => 'credit') { number_to_currency(t.amount) if t.class == Payment }
              td(:class => 'debit') { number_to_currency(t.amount) if t.class == Charge }
            end
          end
        end
        tfoot do
          tr(:class => 'total', :style => 'border-top: 1px solid black;') do
            th(:class => 'label') { "Totals:" }
            th(:class => 'credit') { number_to_currency(member.payments.map(&:amount).sum) }
            th(:class => 'debit') { number_to_currency(member.charges.map(&:amount).sum) }
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Member Details" do
      f.input :name
      f.input :email
      f.input :address
      f.input :phone
      f.input :account_balance
    end
    f.buttons
  end
end

