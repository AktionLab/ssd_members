class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount, :precision => 8, :scale => 2, :null => false
      t.references :payable, :polymorphic => true, :null => false

      t.timestamps
    end
    add_index :payments, :payable_id
  end
end
