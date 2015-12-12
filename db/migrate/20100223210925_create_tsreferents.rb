class CreateTsreferents < ActiveRecord::Migration
  def self.up
    create_table :tsreferents do |t|
      t.integer :ts_request_id
      t.integer :referent_id
      t.integer :mailsend, :default => 0
      t.date :maildate
      t.string :paid, :default => 'nein'

      t.timestamps
    end
  end

  def self.down
    drop_table :tsreferents
  end
end
