class AddInvoiceNumberToWorkshop < ActiveRecord::Migration
  def self.up
    add_column :workshops, :invoice_number, :string
    add_column :workshops, :given_price, :decimal
    add_column :workshops, :paid_price, :decimal
  end

  def self.down
    remove_column :workshops, :paid_price
    remove_column :workshops, :given_price
    remove_column :workshops, :invoice_number
  end
end
