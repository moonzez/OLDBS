class Htsreferent < ActiveRecord::Base
  belongs_to :htseminar
  belongs_to :referent
  
  def self.confirmed_without_referent_mail
    find_all_by_mailsend(false, :include => [:htseminar], :conditions => "created_at > '2012-01-01 00:00:00'")
  end
  
  def self.find_not_paid_for_referent(referent_id, hts_id)
    find_by_htseminar_id_and_referent_id(hts_id, referent_id, :conditions => "paid = 'nein'")
  end
  
end
