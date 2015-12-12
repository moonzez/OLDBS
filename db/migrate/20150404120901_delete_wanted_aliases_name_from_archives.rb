class DeleteWantedAliasesNameFromArchives < ActiveRecord::Migration
  def self.up
    remove_column(:archives, :wanted_aliases_name)
  end

  def self.down
  end
end
