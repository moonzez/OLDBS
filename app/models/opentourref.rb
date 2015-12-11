class Opentourref < ActiveRecord::Base
  belongs_to :opentour
  belongs_to :referent
  
  def self.confirmed_without_referent_mail
    find_all_by_mailsend(false, :include => [:opentour], :conditions => "created_at > '2012-01-01 00:00:00' AND opentour_id IS NOT NULL")
  end

end
