class AddMahnungToTsRequests < ActiveRecord::Migration
  def self.up
    add_column :ts_requests, :mahnung, :integer, :default => 0
    add_column :ts_requests, :mahnungdate, :date
  end

  def self.down
    remove_column :ts_requests, :mahnungdate
    remove_column :ts_requests, :mahnung
  end
end
