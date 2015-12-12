class AddLizenzToReferents < ActiveRecord::Migration
  def self.up
    add_column :referents, :lizenz_hts, :boolean, :default => 0
    add_column :referents, :lizenz_ts_all, :boolean, :default => 0
    add_column :referents, :lizenz_ts_men, :boolean, :default => 0
    add_column :referents, :lizenz_ts_er, :boolean, :default => 0
  end

  def self.down
  end
end
