class AddStornoToWorkshops < ActiveRecord::Migration
  def self.up
    add_column :workshops, :storno_sent, :string, :default => "nein"
    add_column :workshops, :storno_date, :date
  end

  def self.down
    remove_column :workshops, :storno_sent
    remove_column :workshops, :storno_date
  end
end
