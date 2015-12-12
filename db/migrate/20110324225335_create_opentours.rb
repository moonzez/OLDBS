class CreateOpentours < ActiveRecord::Migration
  def self.up
    create_table :opentours do |t|
      t.date :date
      t.time :time
      t.string :comment
      t.string :language
      t.string :status, :default => 'activ'

      t.timestamps
    end
  end

  def self.down
    drop_table :opentours
  end
end