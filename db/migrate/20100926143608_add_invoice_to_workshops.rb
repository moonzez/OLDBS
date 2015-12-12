class AddInvoiceToWorkshops < ActiveRecord::Migration
  def self.up
    add_column :workshops, :invoice, :string, :default => 'ja'
  end

  def self.down
    remove_column :workshops, :invoice
  end
end
