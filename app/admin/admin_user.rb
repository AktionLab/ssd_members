ActiveAdmin.register AdminUser do
  menu :label => 'Members'

  filter :email

  index do
    column :email
    default_actions
  end

  show do
    panel "Member Details - #{admin_user.email}" do
      attributes_table_for admin_user do
        row("Current Sign In") { admin_user.current_sign_in_at? ? l(admin_user.current_sign_in_at, :format => :long) : '-' }
        row("Last Sign In") { admin_user.last_sign_in_at? ? l(admin_user.last_sign_in_at, :format => :long) : 'Never' }
        row("Sign In Count") { admin_user.sign_in_count }
      end
    end
  end

  form do |f|
    f.inputs "Member Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
