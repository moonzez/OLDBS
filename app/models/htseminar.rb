class Htseminar < ActiveRecord::Base
  
  CURRENT_PRICE = 90.00
  PRICE_FROM_APRIL_2016 = 110.00
  
  FROMINTERN = ["09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00",
                        "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00",
                        "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:30"]
  FROMEXTERN = ["09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00",
                        "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00"]
  
  TOINTERN = ["10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", 
                      "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:30", "15:45", "16:00", 
                      "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", "18:00"]
  LANGUAGES = ["Deutsch", "Englisch", "Italienisch"]
  LANGUAGES_INTERN = ["Deutsch", "Englisch", "Französisch", "Italienisch"]
  LANGUAGES_ENG = ["English", "German" , "Italian"]
  LANGUAGES_IT = ["Tedesco", "Inglese", "Italiano"]
  TOPIC_GERMAN = ["Geschichte Konzentrationslager Dachau und der Weg zur Gedenkstätte (Teilnehmerorientierte Vor- und Nacharbeit des Gedenkstättenbesuches)",
                   "Propaganda und Wirklichkeit", "Sklavenarbeit und Überleben", "Lernort KZ-Gedenkstätte Dachau – Menschenrechte", "Zielgruppenorientierte Konzeption (nach Absprache)"]
  TOPIC_ENGLISH = ["History of the Dachau Concentration Camp and the development of the Memorial Site (participative preparation and follow-up of a Memorial Site visit)", 
                   "Propaganda and Reality", "Slave Labor and Survival", "The Memorial Site as a place to learn - Human Rights", "target-group oriented seminar (after agreement)"]
  
  has_many :htsreferents
  has_many :referents, :through => :htsreferents
  
  validates_presence_of     :gender , :firstname, :lastname, :schoolname, :street, :city, :zip, :country, :date1,
    :from1, :to1, :participnumber, :message =>""
   
  validates_presence_of     :foodnumber, :if => "food.eql?('ja')", :message =>""
  
  validates_presence_of     :hl_number, :if => "paid.eql?('ja,überwiesen')" ,
    :message => "Bitte die HÜL-Nummer angeben!"
  
  validates_presence_of :schoolgrade, :if => "!schooltype.blank?", :on => :create, :message => ""
  
  validates_presence_of :age, :if => "!schooltype.blank?", :on => :create, :message => ""
  
  validates_format_of     :email, :with => /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message =>""
  
  validates_presence_of :cellphone, :on => :create, :message =>""
  
  before_validation :set_current_fee
  
  def set_current_fee
    return if current_fee
    return if thedate.blank?
    price = (thedate.to_date >= "2016-04-01".to_date) ? PRICE_FROM_APRIL_2016 : CURRENT_PRICE
    self.current_fee = price
  end
  
  def self.find_all_from_to_thedate(from, to, options ={})
    if options['status']
      find_all_by_status(options['status'], :conditions => "thedate >='"+from+"' and thedate <= '"+to+"'", :order => "thedate, thefrom")
    else
      find(:all, :conditions => "thedate >='"+from+"' and thedate <= '"+to+"'", :order => "thedate, thefrom")
    end
  end
  
  def self.find_all_from_to_date1(from, to, status)
    find_all_by_status(status, :conditions => "date1 >='"+from+"' and date1 <= '"+to+"'", :order => "date1, from1")
  end
  
  def self.find_all_for_thedate(date, status)
    find_all_by_thedate_and_status(date, status, :order => "thefrom")
  end
  
  def self.find_all_for_date1(date, status)
    find_all_by_date1_and_status(date, status, :order => "from1")
  end
  
  def self.find_opened
    find_all_by_status("offen", :order=> "created_at")
  end
  
  def self.find_future
    find_all_by_status("bestätigt", :conditions => "thedate >= curdate()" ,:order=> "thedate, thefrom")
  end
  
  def self.find_denialed
    find_all_by_status("abgesagt", :conditions => "date1 > '2012-01-01 00:00:00'", :order=> "date1, from1")
  end
  
  def self.find_canceled
    find_all_by_status("storniert", :conditions => "date1 > '2012-01-01 00:00:00'", :order=> "date1, from1" )
  end
  
  def self.find_for_year(year)
    find_all_by_status('bestätigt', :conditions => "substr(thedate,1,4) = '"+year+"'", :order => 'thedate')
  end
  
  def self.search_hts(params)
    conditions = []
    conditions.push(["htseminars.firstname LIKE '%#{params[:firstname]}%'"]) unless params[:firstname].blank?
    conditions.push(["htseminars.lastname LIKE '%#{params[:lastname]}%'"]) unless params[:lastname].blank?
    conditions.push(["htseminars.schoolname LIKE '%#{params[:schoolname]}%'"]) unless params[:schoolname].blank?
    conditions.push(["htseminars.city LIKE '%#{params[:city]}%'"]) unless params[:city].blank?
    conditions.push(["htseminars.status LIKE '%#{params[:status]}%'"]) unless params[:status].blank?
    conditions.push(["htseminars.topic LIKE '%#{params[:topic]}%'"]) unless params[:topic].blank?
    conditions.push(["htseminars.invoice_number LIKE '%#{params[:invoice_number]}%'"]) unless params[:invoice_number].blank?
    conditions.push(["htseminars.hl_number LIKE '%#{params[:hl_number]}%'"]) unless params[:hl_number].blank?
    if !params[:country].blank? and params[:country].length > 2
      conditions.push(["htseminars.country LIKE '%#{params[:country]}%'"])
    end
    conditions = conditions.flatten.join(" AND ")
    if conditions.empty?
      []
    else
      find(:all, :conditions => conditions)
    end
  end
  
  def self.find_for_month(beginning_of_month, referent_id)
    htseminars = []
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :order=> "thedate", 
      :conditions => "thedate >= '" + beginning_of_month.to_s + "' AND thedate <= '" + month_end.to_s + "' AND status = 'bestätigt'")
    all_results.each do |single_hts|
      if single_hts.htsreferents.find_not_paid_for_referent(referent_id, single_hts.id)
        htseminars << single_hts
      end
    end
    htseminars
  end
  
  #TODO refactor
  def self.set_paid(beginning_of_month, referent_id)
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :conditions => "thedate >= '" + beginning_of_month.to_s + "' AND thedate <= '" + month_end.to_s + "' AND status = 'bestätigt'")
    all_results.each do |single_hts|
      htsreferent = single_hts.htsreferents.find_by_referent_id(referent_id)
      if htsreferent.paid == 'nein'
        changed_by = 'automatic generated bill for ' + beginning_of_month.to_s
        #htsreferent.update_attributes(:paid => 'ja', :changed_by => changed_by, :changed_on => Time.now)
      end
    end
  end
end
