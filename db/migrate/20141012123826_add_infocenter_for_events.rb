class AddInfocenterForEvents < ActiveRecord::Migration
  def self.up
    add_column :detours, :infocenter, :text
    add_column :htseminars, :infocenter, :text
    add_column :ts_requests, :infocenter, :text
    add_column :workshops, :infocenter, :text
    add_column :opentours, :infocenter, :text
  end

  def self.down
  end
end
