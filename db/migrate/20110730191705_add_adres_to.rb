class AddAdresTo < ActiveRecord::Migration
  def self.up
    add_column :referents, :zip, :string, :default => ""
    add_column :referents, :city, :string, :default => ""
    add_column :referents, :street, :string, :default => ""
    add_column :referents, :country, :string, :default => ""
  end

  def self.down
    remove_column :referents, :zip
    remove_column :referents, :city
    remove_column :referents, :street
    remove_column :referents, :country
  end
end
