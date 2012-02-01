class CreateDues < ActiveRecord::Migration
  def change
    create_table :dues do |t|
      t.datetime :date
      t.decimal :business_rate, :precision => 8, :scale => 2
      t.decimal :regular_rate, :precision => 8, :scale => 2
      t.decimal :student_rate, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
