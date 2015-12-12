class ChangeStringToTextOnComment < ActiveRecord::Migration
  def self.up
    change_column :detours, :comments, :text
    change_column :htseminars, :comments, :text
    change_column :opentours, :comment, :text
    change_column :ts_requests, :comments, :text
    change_column :workshops, :comments, :text
  end

  def self.down
  end
end
