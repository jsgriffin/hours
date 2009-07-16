class CreateIntervals < ActiveRecord::Migration
  def self.up
    create_table :intervals do |t|
      t.integer :client_id
      t.datetime :start
      t.datetime :end
      t.text :task

      t.timestamps
    end
  end

  def self.down
    drop_table :intervals
  end
end
