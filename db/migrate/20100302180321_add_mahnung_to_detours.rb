class AddMahnungToDetours < ActiveRecord::Migration
  def self.up
    add_column :detours, :mahnung, :integer, :default => 0
    add_column :detours, :mahnungdate, :date
  end

  def self.down
    remove_column :detours, :mahnungdate
    remove_column :detours, :mahnung
  end
end
