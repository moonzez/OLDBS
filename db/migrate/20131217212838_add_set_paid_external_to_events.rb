class AddSetPaidExternalToEvents < ActiveRecord::Migration
  def self.up
    add_column :detours, :set_paid_external, :string
    add_column :htseminars, :set_paid_external, :string
    add_column :ts_requests, :set_paid_external, :string
    add_column :workshops, :set_paid_external, :string
  end

  def self.down
  end
end
