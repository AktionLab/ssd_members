class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount, :precision => 8, :scale => 2, :null => false
      t.references :source, :polymorphic => true, :null => false

      t.timestamps
    end
    add_index :payments, :source_id
  end
end
