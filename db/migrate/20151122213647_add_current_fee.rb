class AddCurrentFee < ActiveRecord::Migration
  def self.up
    add_column :detours, :current_fee, :decimal, :precision => 8, :scale => 2
    add_column :htseminars, :current_fee, :decimal, :precision => 8, :scale => 2
    add_column :ts_requests, :current_fee, :decimal, :precision => 8, :scale => 2
    add_column :workshops, :current_fee, :decimal, :precision => 8, :scale => 2
  end

  def self.down
  end
end
