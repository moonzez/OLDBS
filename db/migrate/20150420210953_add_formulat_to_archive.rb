class AddFormulatToArchive < ActiveRecord::Migration
  def self.up
    add_column :archives, :formular, :string
    
    query = "update archives set formular = 'de'"    
    execute query
  end

  def self.down
  end
end
