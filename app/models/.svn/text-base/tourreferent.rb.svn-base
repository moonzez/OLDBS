class Tourreferent < ActiveRecord::Base
  belongs_to :detour
  belongs_to :referent
  
  def self.confirmed_without_referent_mail
    find_all_by_mailsend(false, :include => [:detour], :conditions => "created_at > '2012-01-01 00:00:00'")
  end
  
  def self.find_not_paid_for_referent(referent_id, detour_id)
    find_by_detour_id_and_referent_id(detour_id, referent_id, :conditions => "paid = 'nein'")
  end
end
