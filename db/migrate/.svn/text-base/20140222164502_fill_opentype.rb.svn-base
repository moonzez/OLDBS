class FillOpentype < ActiveRecord::Migration
  def self.up
    Opentour.all.each do |ot|
      if ((ot.comment =~ /THEME/) || (ot.comment =~ /Thematisch/) || (ot.comment =~ /Theme/))
        ot.opentype = "THEMENFÜHRUNG"
        ot.save
      end
    end
  end

  def self.down
  end
end
