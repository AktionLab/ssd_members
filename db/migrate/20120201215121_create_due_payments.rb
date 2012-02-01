class CreateDuePayments < ActiveRecord::Migration
  def change
    create_table :due_payments do |t|
      t.references :admin_user
      t.references :due
      t.decimal :amount, :precision => 8, :scale => 2

      t.timestamps
    end
    add_index :due_payments, :admin_user_id
    add_index :due_payments, :due_id
  end
end
