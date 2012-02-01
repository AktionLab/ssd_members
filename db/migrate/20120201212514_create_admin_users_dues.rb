class CreateAdminUsersDues < ActiveRecord::Migration
	def change
		create_table :dues_admin_users, :id => false do |t|
			t.references :admin_user
			t.references :due
		end
	end
end
