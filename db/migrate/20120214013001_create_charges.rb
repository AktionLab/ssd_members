class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.decimal :amount, :precision => 8, :scale => 2, :null => false
      t.references :chargeable, :polymorphic => true, :null => false

      t.timestamps
    end
    add_index :charges, :chargeable_id
  end
end
