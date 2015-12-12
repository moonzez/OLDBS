class AddInvoiceToDetours < ActiveRecord::Migration
  def self.up
    add_column :detours, :invoice, :string, :default => 'ja'
  end

  def self.down
    remove_column :detours, :invoice
  end
end
