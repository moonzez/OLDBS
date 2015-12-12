class AddStornoToTsRequests < ActiveRecord::Migration
  def self.up
    add_column :ts_requests, :storno_sent, :string, :default => "nein"
    add_column :ts_requests, :storno_date, :date
  end

  def self.down
    remove_column :ts_requests, :storno_sent
    remove_column :ts_requests, :storno_date
  end
end
