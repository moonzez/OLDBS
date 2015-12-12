class AddMahnungToWorkshops < ActiveRecord::Migration
  def self.up
    add_column :workshops, :mahnung, :integer, :default => 0
    add_column :workshops, :mahnungdate, :date
  end

  def self.down
    remove_column :workshops, :mahnungdate
    remove_column :workshops, :mahnung
  end
end
