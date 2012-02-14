class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.decimal :account_balance, :precision => 8, :scale => 2
      t.string :account_category

      t.timestamps
    end
  end
end
