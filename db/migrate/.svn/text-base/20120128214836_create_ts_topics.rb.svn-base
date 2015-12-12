class CreateTsTopics < ActiveRecord::Migration
  def self.up
    create_table :ts_topics do |t|
      t.string :text
      t.string :language
    end
  end

  def self.down
    drop_table :ts_topics
  end
end
