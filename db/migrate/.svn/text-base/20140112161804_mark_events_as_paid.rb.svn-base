class MarkEventsAsPaid < ActiveRecord::Migration
  def self.up
    add_column :tourreferents, :changed_by, :string
    add_column :tourreferents, :changed_on, :datetime
    
    add_column :tsreferents, :changed_by, :string
    add_column :tsreferents, :changed_on, :datetime
    
    add_column :htsreferents, :changed_by, :string
    add_column :htsreferents, :changed_on, :datetime
    
    add_column :workreferents, :changed_by, :string
    add_column :workreferents, :changed_on, :datetime
    
    add_column :opentourrefs, :changed_by, :string
    add_column :opentourrefs, :changed_on, :datetime
  end

  def self.down
  end
end
