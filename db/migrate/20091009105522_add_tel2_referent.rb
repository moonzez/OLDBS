class AddTel2Referent < ActiveRecord::Migration
  def self.up
    add_column :referents, :tel2, :string
    remove_column :referents, :age
  end

  def self.down
    remove_column :referents, :tel2
    add_column :referents, :age, :integer
  end
end
