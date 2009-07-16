class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.integer :user_id
      t.string :name
      t.float :rate

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
