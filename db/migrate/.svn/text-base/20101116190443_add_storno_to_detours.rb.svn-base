class AddStornoToDetours < ActiveRecord::Migration
  def self.up
    add_column :detours, :storno_send, :string, :default => "nein"
    add_column :detours, :storno_date, :date
  end

  def self.down
    remove_column :detours, :storno_send
    remove_column :detours, :storno_date
  end
end
