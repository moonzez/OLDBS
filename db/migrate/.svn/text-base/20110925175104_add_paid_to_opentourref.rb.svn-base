class AddPaidToOpentourref < ActiveRecord::Migration
  def self.up
    add_column :opentourrefs, :paid, :string, :default => 'nein'
  end

  def self.down
    remove_column :opentourrefs, :paid
  end
end
