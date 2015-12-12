class ChangeGivenPrice < ActiveRecord::Migration
  def self.up
    Detour.find(:all, :conditions => "given_price IS NOT NULL").each do |tour|
      tour.given_price *= tour.groupnumber
      tour.save
    end
    
    Htseminar.find(:all, :conditions => "given_price IS NOT NULL").each do |hts|
      hts.given_price *= hts.groupnumber
      hts.save
    end
    
    TsRequest.find(:all, :conditions => "given_price IS NOT NULL").each do |ts|
      ts.given_price *= ts.groupnumber
      ts.save
    end
  end

  def self.down
  end
end
