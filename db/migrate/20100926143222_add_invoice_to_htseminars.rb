class AddInvoiceToHtseminars < ActiveRecord::Migration
  def self.up
    add_column :htseminars, :invoice, :string, :default => 'ja'
  end

  def self.down
    remove_column :htseminars, :invoice
  end
end
