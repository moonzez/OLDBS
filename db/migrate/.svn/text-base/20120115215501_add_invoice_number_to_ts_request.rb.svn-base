class AddInvoiceNumberToTsRequest < ActiveRecord::Migration
  def self.up
    add_column :ts_requests, :invoice_number, :string
    add_column :ts_requests, :given_price, :decimal, :precision => 8, :scale => 2
    add_column :ts_requests, :paid_price, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end

  def self.down
    remove_column :ts_requests, :paid_price
    remove_column :ts_requests, :given_price
    remove_column :ts_requests, :invoice_number
  end
end
