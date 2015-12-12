class AddInvoiceNumberToHtseminar < ActiveRecord::Migration
  def self.up
    add_column :htseminars, :invoice_number, :string
    add_column :htseminars, :given_price, :decimal, :precision => 8, :scale => 2
    add_column :htseminars, :paid_price, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end

  def self.down
    remove_column :htseminars, :paid_price
    remove_column :htseminars, :given_price
    remove_column :htseminars, :invoice_number
  end
end
