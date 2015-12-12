class CreateReferents < ActiveRecord::Migration
  def self.up
    create_table :referents do |t|
      t.string :gender
      t.string :firstname
      t.string :lastname
      t.string :tel
      t.string :email
      t.integer :age #wird in add_tel2_referent gelöscht, 2.Telefon wird hinzugefügt als tel2 Attribut
      t.string :language1
      t.string :language2
      t.string :language3
      t.string :remarc
      t.integer :vers, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :referents
  end
end
