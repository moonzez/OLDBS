class Opentour < ActiveRecord::Base  
  has_many :opentourwishes
  has_many :referenten, :through => :opentourwishes, :source => :referent
  
  has_one :opentourref
  has_one :referent, :through => :opentourref
    
  STARTTIMES = ['09:00', '09:15', '09:30', '09:45', '10:00', '10:15', '10:30', '10:45',
                '11:00', '11:15', '11:30', '11:45', '12:00', '12:15', '12:30', '12:45',
                '13:00', '13:15', '13:30', '13:45', '14:00']
  
  def self.find_all_from_to_date(from, to, options ={})
    if options['status']
      find_all_by_status(options['status'], :conditions => "date >='"+from+"' and date <= '"+to+"'", :order => "date, time")
    else
      find(:all, :conditions => "date >='"+from+"' and date <= '"+to+"'", :order => "date, time")
    end
  end
  
  def self.find_all_from_to_date_with_referent(from, to)
    find_all_by_status('activ', :conditions => "date >='"+from+"' and date <= '"+to+"'", :order => "date, time", :include => [:referenten, :referent])
  end
  
  def self.find_all_with_referent(from, to)
    find(:all, :conditions => "date >='"+from+"' and date <= '"+to+"'", :order => "date, time", :include => [:referenten, :referent])
  end
  
  def self.find_all_with_referents_and_languages(from, to, in_condition)
    find(:all, :conditions => "date >='"+from+"' and date <= '"+to+"' and status = 'activ' and language IN #{in_condition}", :order => "date, time", :include => [:referenten, :referent])
  end
  
  def self.find_all_for_date(data)
    find(:all, :conditions => "date ='"+data+"' and status = 'activ'", :include => [:referenten, :referent])
  end
  
  def self.find_for_year(year)
    find_all_by_status('activ', :conditions => "substr(date,1,4) = '"+year+"'", :order => 'date, time')
  end
  
  def self.find_for_month(beginning_of_month, referent_id)
    opentours = []
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :order=> "date",
      :conditions => "date >= '" + beginning_of_month.to_s + "' AND date <= '" + month_end.to_s + "' AND status = 'activ'")
    all_results.each do |single_opentour|
      if (single_opentour.opentourref && single_opentour.referent)
        if (single_opentour.referent.id == referent_id && single_opentour.opentourref.paid != 'ja')
          opentours << single_opentour
        end
      end
    end
    opentours
  end
  #TODO: refactor
  def self.set_paid(beginning_of_month, referent_id)
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :conditions => "date >= '" + beginning_of_month.to_s + "' AND date <= '" + month_end.to_s + "' AND status = 'activ'")
    all_results.each do |single_opentour|
      if (single_opentour.opentourref && single_opentour.referent)
        if (single_opentour.referent.id == referent_id)
          if (single_opentour.opentourref.paid == 'nein')
            changed_by = 'automatic bill for ' + beginning_of_month.to_s
            #opentourref.update_attributes(:paid => 'ja', :changed_by => changed_by, :changed_on => Time.now)
          end
        end
      end
    end
  end

end
