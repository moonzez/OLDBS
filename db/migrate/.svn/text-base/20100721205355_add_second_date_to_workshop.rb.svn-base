class AddSecondDateToWorkshop < ActiveRecord::Migration
  def self.up
    add_column :workshops, :date2, :date
    add_column :workshops, :from2, :time
    add_column :workshops, :to2, :time
  end

  def self.down
    remove_column :workshops, :date2, :date
    remove_column :workshops, :from2, :time
    remove_column :workshops, :to2, :time
  end
end
