class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.decimal :amount, :precision => 21, :scale => 5
      t.integer :city_id
      t.timestamps
    end
  end
end
