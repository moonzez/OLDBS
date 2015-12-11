class Workshop < ActiveRecord::Base
  
  CURRENT_PRICE = 80.00
  
  FROMINTERN = ["09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00",
    "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00",
    "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:30"]
  TOINTERN = ["10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", 
    "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:30", "15:45", "16:00", 
    "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", "18:00"]
   
  has_many :workreferents
  has_many :referents, :through => :workreferents
  
  validates_presence_of     :gender,
  :message => "Wählen Sie bitte die Anrede aus." 

  validates_presence_of     :firstname,
    :message => "Geben Sie bitte den Vornamen ein."
  
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
    :message =>"Der Terminauswahl darf nicht fehlen!"
  
   validates_numericality_of :participnumber, :on => :create,
     :greater_than_or_equal_to => 1, :less_than => 36,
     :message =>"Geben Sie bitte eine gültige Anzahl der Teilnehmer ein."
 
#  validates_presence_of    :participnumber,
#     :message =>"Geben Sie bitte die Anzahl der Teilnehmer ein."
   
   validates_presence_of     :foodnumber, :if => "food.eql?('ja')" ,
    :message => "Bitte die Personenzahl, f&uuml;r die das Mittagsessen organisiert werden soll, angeben!"
  
   validates_presence_of :schoolgrade, :if => "!schooltype.blank?", :on => :create, :message => "Geben Sie bitte die Schulstufe ein."
  
   validates_presence_of :age, :if => "!schooltype.blank?", :on => :create, :message => "Geben Sie bitte Alter der Teilnehmer ein."
   
   validates_presence_of :cellphone, :on => :create, :message => "Handynummer der Begleitperson darf nicht leer sein."
   
#  validates_exclusion_of :foodnumber,:in => 0..0,:if => "foodnumber > participnumber" ,
#  :message =>"Die Anzahl der Teilnehmer, f&uuml;r die das Mittagsessen organisiert werden soll,
#   darf nicht gr&ouml;ßer als die gesamte Anzahl der Teilnehmer sein."
  
#  validates_exclusion_of     :foodnumber, :in => 0..10000000, :if => "food.eql?('nein')" ,
#    :message => "Sie haben die Personenanzahl eingegeben, f&uuml;r die das Mittagsessen organisiert werden soll,
#   aber 'nein' ausgewählt!"
  
  validates_presence_of     :hl_number, :if => "paid.eql?('ja,überwiesen')" ,
    :message => "Bitte die HÜL-Nummer angeben!"
  
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

  def self.search_work(params)
    conditions = []
    conditions.push(["workshops.firstname LIKE '%#{params[:firstname]}%'"]) unless params[:firstname].blank?
    conditions.push(["workshops.lastname LIKE '%#{params[:lastname]}%'"]) unless params[:lastname].blank?
    conditions.push(["workshops.schoolname LIKE '%#{params[:schoolname]}%'"]) unless params[:schoolname].blank?
    conditions.push(["workshops.city LIKE '%#{params[:city]}%'"]) unless params[:city].blank?
    conditions.push(["workshops.status LIKE '%#{params[:status]}%'"]) unless params[:status].blank?
    conditions.push(["workshops.invoice_number LIKE '%#{params[:invoice_number]}%'"]) unless params[:invoice_number].blank?
    conditions.push(["workshops.hl_number LIKE '%#{params[:hl_number]}%'"]) unless params[:hl_number].blank?
    if !params[:country].blank? and params[:country].length > 2
      conditions.push(["workshops.country LIKE '%#{params[:country]}%'"])
    end
    conditions = conditions.flatten.join(" AND ")
    if conditions.empty?
      []
    else
      find(:all, :conditions => conditions)
    end
  end
  
  def self.find_for_month(beginning_of_month, referent_id)
    workshops = []
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :order=> "thedate",
      :conditions => "thedate >= '" + beginning_of_month.to_s + "' AND thedate <= '" + month_end.to_s + "' AND status = 'bestätigt'")
    all_results.each do |single_work|
      if single_work.workreferents.find_not_paid_for_referent(referent_id, single_work.id)
        workshops << single_work
      end
    end
    workshops
  end

      #TODO refactor
  def self.set_paid(beginning_of_month, referent_id)
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :conditions => "thedate >= '" + beginning_of_month.to_s + "' AND thedate <= '" + month_end.to_s + "' AND status = 'bestätigt'")
    all_results.each do |single_work|
      workreferent = single_work.workreferents.find_by_referent_id(referent_id)
      if workreferent.paid == 'nein'
        changed_by = 'automatic generated bill for ' + beginning_of_month.to_s
        #workreferent.update_attributes(:paid => 'ja', :changed_by => changed_by, :changed_on => Time.now)
      end
    end
  end
end
