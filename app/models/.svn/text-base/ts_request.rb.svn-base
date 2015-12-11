class TsRequest < ActiveRecord::Base
  
  CURRENT_PRICE = 120.00
  PRICE_FROM_APRIL_2016 = 180.00
  
  FROMINTERN = ["09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00", 
                                 "11:15", "11:30", "11:45", "12:00", "12:15", "12:30"]
                               
  FROMEXTERN = ["09:00", "09:30", "10:00"]
  
  TOINTERN = ["15:00", "15:30", "15:45", "16:00", "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", "18:00"]
          
  has_many :tsreferents
  has_many :referents, :through => :tsreferents
  
  validates_presence_of     :gender,
    :message => "Wählen Sie bitte die Anrede aus." 
  
  validates_presence_of     :firstname,
    :message =>"Geben Sie bitte den Vornamen ein."
  
  validates_presence_of     :lastname,
    :message =>"Geben Sie bitte den Namen ein."
  
  validates_format_of     :email, :with => /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create,
    :message => "Geben Sie bitte eine g&uuml;ltige E-Mail-Adresse ein."
  
   validates_presence_of     :schoolname,  
  :message =>"Geben Sie bitte den Namen der Schule/Institution ein."

  validates_presence_of     :street,  
  :message =>"Geben Sie bitte die Adresse der Schule/Institution ein."

  validates_presence_of     :city,  
  :message =>"Geben Sie bitte den Ort der Schule/Institution ein." 


  validates_presence_of     :zip, 
  :message => "Geben Sie bitte eine Postleitzahl ein." 

 validates_presence_of     :country,  
  :message => "Geben Sie bitte das Land der Schule/Institution ein." 

  validates_presence_of     :date1,
     :message =>"1.Termin darf nicht fehlen."

   validates_presence_of     :from1,
     :message =>"Die erste Uhrzeit des 1.Termins darf nicht fehlen."
    
  validates_presence_of     :to1, 
     :message =>"Die zweite Uhrzeit des 1.Termins darf nicht fehlen."
   
 validates_presence_of     :topic,
 :message =>"Wählen Sie bitte ein Thema für das Tagesseminar aus."

  validates_presence_of    :participnumber,
     :message =>"Geben Sie bitte die Anzahl der Teilnehmer ein."
   
  validates_presence_of     :foodnumber, :if => "food.eql?('ja')" ,
    :message => "Bitte die Personenzahl,f&uuml;r die das Mittagsessen organisiert werden soll, angeben!"
  

  validates_presence_of     :hl_number, :if => "paid.eql?('ja,überwiesen')" ,
    :message => "Bitte die HÜL-Nummer angeben!"
  
  validates_presence_of :schoolgrade, :if => "!schooltype.blank?", :on => :create, :message => "Geben Sie bitte die Schulstufe ein."
  
  validates_presence_of :age, :if => "!schooltype.blank?", :on => :create, :message => "Geben Sie bitte Alter der Teilnehmer ein."
  
  validates_presence_of :cellphone, :on => :create, :message => "Handynummer der Begleitperson darf nicht leer sein."
  
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
  
  def self.find_storniert
    find_all_by_status("storniert", :conditions => "date1 > '2012-01-01 00:00:00'", :order=> "date1")
  end
  
  def self.find_opened
    find_all_by_status("offen", :conditions => "date1 > '2012-01-01 00:00:00'", :order=> "created_at")
  end
  
  def self.find_future
    find_all_by_status("bestätigt", :conditions => "thedate >= curdate()" ,:order=> "thedate, thefrom")
  end
  
  def self.find_denialed
    find_all_by_status("abgesagt", :order=> "date1, from1")
  end
  
   def self.find_canceled
    find_all_by_status("storniert", :order=> "date1, from1" )
  end
  
  def self.find_for_year(year)
    find_all_by_status('bestätigt', :conditions => "substr(thedate,1,4) = '"+year+"'", :order => 'thedate')
  end

  def self.search_ts(params)
    conditions = []
    conditions.push(["ts_requests.firstname LIKE '%#{params[:firstname]}%'"]) unless params[:firstname].blank?
    conditions.push(["ts_requests.lastname LIKE '%#{params[:lastname]}%'"]) unless params[:lastname].blank?
    conditions.push(["ts_requests.schoolname LIKE '%#{params[:schoolname]}%'"]) unless params[:schoolname].blank?
    conditions.push(["ts_requests.city LIKE '%#{params[:city]}%'"]) unless params[:city].blank?
    conditions.push(["ts_requests.status LIKE '%#{params[:status]}%'"]) unless params[:status].blank?
    conditions.push(["ts_requests.topic LIKE '%#{params[:topic]}%'"]) unless params[:topic].blank?
    conditions.push(["ts_requests.invoice_number LIKE '%#{params[:invoice_number]}%'"]) unless params[:invoice_number].blank?
    conditions.push(["ts_requests.hl_number LIKE '%#{params[:hl_number]}%'"]) unless params[:hl_number].blank?
    if !params[:country].blank? and params[:country].length > 2
      conditions.push(["ts_requests.country LIKE '%#{params[:country]}%'"])
    end
    conditions = conditions.flatten.join(" AND ")
    if conditions.empty?
      []
    else
      find(:all, :conditions => conditions)
    end
  end
  
  def self.find_for_month(beginning_of_month, referent_id)
    ts_requests = []
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :order=> "thedate",
      :conditions => "thedate >= '" + beginning_of_month.to_s + "' AND thedate <= '" + month_end.to_s + "' AND status = 'bestätigt'")
    all_results.each do |single_ts|
      if single_ts.tsreferents.find_not_paid_for_referent(referent_id, single_ts.id)
        ts_requests << single_ts
      end
    end
    ts_requests
  end
  
    #TODO refactor
  def self.set_paid(beginning_of_month, referent_id)
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :conditions => "thedate >= '" + beginning_of_month.to_s + "' AND thedate <= '" + month_end.to_s + "' AND status = 'bestätigt'")
    all_results.each do |single_ts|
      tsreferent = single_ts.tsreferents.find_by_referent_id(referent_id)
      if tsreferent.paid == 'nein'
        changed_by = 'automatic generated bill for ' + beginning_of_month.to_s
        #tsreferent.update_attributes(:paid => 'ja', :changed_by => changed_by, :changed_on => Time.now)
      end
    end
  end
end

