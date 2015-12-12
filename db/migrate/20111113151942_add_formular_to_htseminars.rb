class AddFormularToHtseminars < ActiveRecord::Migration
  def self.up
    add_column :htseminars, :formular, :string
  end

  def self.down
    remove_column :htseminars, :formular
  end
end
