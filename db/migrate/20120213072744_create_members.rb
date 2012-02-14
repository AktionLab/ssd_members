class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :address
      t.string :phone
      t.decimal :account_balance, :precision => 8, :scale => 2, :null => false, :default => 0.0
      t.string :account_category, :null => false

      t.timestamps
    end
  end
end
