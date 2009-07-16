class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.integer :client_id
      t.string :name
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
