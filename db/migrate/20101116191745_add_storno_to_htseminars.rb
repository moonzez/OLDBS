class AddStornoToHtseminars < ActiveRecord::Migration
  def self.up
    add_column :htseminars, :storno_send, :string, :default => "nein"
    add_column :htseminars, :storno_date, :date
  end

  def self.down
    remove_column :htseminars, :storno_send
    remove_column :htseminars, :storno_date
  end
end
