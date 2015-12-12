class ResultSent < ActiveRecord::Migration
  def self.up
    add_column :detours, :result_sent, :boolean, :default => 1
    add_column :ts_requests, :result_sent, :boolean, :default => 1
    add_column :htseminars, :result_sent, :boolean, :default => 1
    add_column :workshops, :result_sent, :boolean, :default => 1
  end

  def self.down
  end
end
