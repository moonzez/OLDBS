class AddInvoiceToTsRequests < ActiveRecord::Migration
  def self.up
    add_column :ts_requests, :invoice, :string, :default => 'ja'
  end

  def self.down
    remove_column :ts_requests, :invoice
  end
end
