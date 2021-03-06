class CreateStorageStrategies < ActiveRecord::Migration
  def self.up
    create_table :storage_strategies do |t|
      t.string :code, :null => false, :unique => true, :limit => 10
      t.string :name, :null => false, :limit => 50
      t.string :description, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :storage_strategies
  end
end
