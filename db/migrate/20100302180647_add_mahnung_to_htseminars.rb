class AddMahnungToHtseminars < ActiveRecord::Migration
  def self.up
    add_column :htseminars, :mahnung, :integer, :default => 0
    add_column :htseminars, :mahnungdate, :date
  end

  def self.down
    remove_column :htseminars, :mahnungdate
    remove_column :htseminars, :mahnung
  end
end
