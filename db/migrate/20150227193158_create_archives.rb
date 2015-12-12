class CreateArchives < ActiveRecord::Migration
  def self.up
    create_table :archives do |t|
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :city
      t.integer :zip
      t.string :country
      t.string :email
      t.string :relationship
      t.text :investigation
      
      t.string :wanted_firstname
      t.string :wanted_lastname
      t.string :wanted_birth_name
      t.string :wanted_aliases_name
      t.string :wanted_birth_date
      t.string :wanted_birthplace
      t.text :wanted_additional
      t.timestamps
    end
  end

  def self.down
    drop_table :archives
  end
end
