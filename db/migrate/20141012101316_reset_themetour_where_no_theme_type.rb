class ResetThemetourWhereNoThemeType < ActiveRecord::Migration
  def self.up
    Detour.find_all_by_themetour_and_theme_type(true, nil).each do |d|
      d.update_attribute(:themetour, false)
    end
  end

  def self.down
  end
end
