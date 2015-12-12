class CreateWorkreferents < ActiveRecord::Migration
  def self.up
    create_table :workreferents do |t|
      t.integer :workshop_id
      t.integer :referent_id
      t.integer :mailsend, :default => 0
      t.date :maildate
      t.string :paid, :default => 'nein'

      t.timestamps
    end
  end

  def self.down
    drop_table :workreferents
  end
end
