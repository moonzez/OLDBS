class AddInvoiceNumberToDetours < ActiveRecord::Migration
  def self.up
    add_column :detours, :invoice_number, :string
    add_column :detours, :given_price, :decimal, :precision => 8, :scale => 2
    add_column :detours, :paid_price, :decimal, :precision => 8, :scale => 2, :default => 0.0
  end

  def self.down
    remove_column :detours, :invoice_number
    remove_column :detours, :given_price
    remove_column :detours, :paid_price
  end
end
