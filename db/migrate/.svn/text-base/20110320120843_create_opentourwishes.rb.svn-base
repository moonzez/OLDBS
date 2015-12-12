class CreateOpentourwishes < ActiveRecord::Migration
  def self.up
    create_table :opentourwishes do |t|
      t.integer :opentour_id
      t.integer :referent_id
      t.integer :mailsend, :default => 0
      t.date :maildate

      t.timestamps
    end
  end

  def self.down
    drop_table :opentourwishes
  end
end
