class Detour < ActiveRecord::Base

  CURRENT_PRICE = 70.00
  PRICE_FROM_APRIL_2016 = 90.00
  
  FROMEXTERN = ["09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00",
                        "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00",
                        "13:15", "13:30", "13:45", "14:00", "14:15", "14:30"]
  FROMINTERN =  FROMEXTERN + ["14:15", "14:30", "14:45", "15:00", "15:30"]
  
  TOINTERN = ["10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", 
                      "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:15", "15:30", "15:45", "16:00", 
                      "16:15", "16:30", "16:45", "17:00", "17:15", "17:30", "17:45", "18:00"]
                    
  LANGUAGES = ["Arabisch", "Deutsch", "Englisch", "Finnisch", "Französisch", "Hebräisch", "Italienisch", "Japanisch", "Polnisch", "Russisch", "Slowakisch",
    "Spanisch", "Tschechisch"]
 
  LANGUAGES_ENG = ["Arabic", "English", "Czech", "Finnish", "French", "German", "Hebrew", "Italian", "Japanese", "Polish", "Russian", "Slovakian", "Spanish" ]
  LANGUAGES_IT = ["Arabo", "Tedesco", "Inglese", "Finlandese", "Francese", "Ebraico", "Italiano", "Giapponese", "Polacco", "Russo", "Slovacco", "Spagnolo", "Ceco"]
  
  LANGUAGES_FR = ["Arabe", "Allemand", "Anglais", "Finlandais", "Français", "Hébreu", "Italien", "Japonais", "Polonais", "Russe", "Slovaque", "Espagnol", "Tchèque"]
  
  attr_accessor :institution, :schooltype_vor1, :schooltype_vor2, :schooltype_input1, :schooltype_input2              
  has_many :tourreferents
  has_many :referents, :through => :tourreferents
  
  validates_presence_of :gender, :firstname, :lastname, :schoolname, :street, :city, :zip, :country, 
    :date1, :from1, :to1, :participnumber, :message =>""  
  
  #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message =>""
  validates_format_of :email, :with => /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message =>""
   
  validates_numericality_of :participnumber, :on => :create, :greater_than_or_equal_to => 1, :message => ""

  validates_presence_of :hl_number, :if => "paid.eql?('ja,überwiesen')", :message => ""
  
  validates_presence_of :topic, :if => "themetour" , :message => ""
  
  validates_presence_of :schoolgrade, :if => "!schooltype.blank?", :on => :create, :message => ""
  
  validates_presence_of :age, :if => "!schooltype.blank?", :on => :create, :message => ""
  
  validates_presence_of :cellphone, :on => :create, :message => ""
  
  before_validation :set_current_fee
  
  def set_current_fee
    return if current_fee
    return if thedate.blank?
    price = (thedate.to_date >= "2016-04-01".to_date) ? PRICE_FROM_APRIL_2016 : CURRENT_PRICE
    self.current_fee = price
  end
  
  def get_all_languages
    all_languages = LANGUAGES.collect

    all_languages = all_languages.push(self.language) unless all_languages.include?(self.language)
    all_languages.sort
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
    find_all_by_status("bestätigt", :conditions => "thedate >= curdate()" ,:order=> "thedate, thefrom", :include => [:referents, :tourreferents])
  end

  def self.find_denialed
    find_all_by_status("abgesagt", :conditions => "date1 > '2012-01-01 00:00:00'", :order=> "date1, from1" )
  end
  
  def self.find_canceled
    find_all_by_status("storniert", :conditions => "date1 > '2012-01-01 00:00:00'", :order=> "date1, from1" )
  end
  
  def self.find_for_year(year)
    find_all_by_status('bestätigt', :conditions => "substr(thedate,1,4) = '"+year+"'", :order => 'thedate, thefrom')
  end
  
  def self.search_detours(params)
    conditions = []
    conditions.push(["detours.firstname LIKE '%#{params[:firstname]}%'"]) unless params[:firstname].blank?
    conditions.push(["detours.lastname LIKE '%#{params[:lastname]}%'"]) unless params[:lastname].blank?
    conditions.push(["detours.schoolname LIKE '%#{params[:schoolname]}%'"]) unless params[:schoolname].blank?
    conditions.push(["detours.city LIKE '%#{params[:city]}%'"]) unless params[:city].blank?
    conditions.push(["detours.status LIKE '%#{params[:status]}%'"]) unless params[:status].blank?
    conditions.push(["detours.language LIKE '%#{params[:language]}%'"]) unless params[:language].blank?
    conditions.push(["detours.invoice_number LIKE '%#{params[:invoice_number]}%'"]) unless params[:invoice_number].blank?
    conditions.push(["detours.hl_number LIKE '%#{params[:hl_number]}%'"]) unless params[:hl_number].blank?
    if !params[:country].blank? and params[:country].length > 2
      conditions.push(["detours.country LIKE '%#{params[:country]}%'"])
    end
    conditions = conditions.flatten.join(" AND ")
    if conditions.empty?
      []
    else
      find(:all, :conditions => conditions)
    end
  end
  
  def self.find_for_month(beginning_of_month, referent_id)
    detours = []
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :order=> "thedate", 
      :conditions => "thedate >= '" + beginning_of_month.to_s + "' AND thedate <= '" + month_end.to_s + "' AND status = 'bestätigt'")
    all_results.each do |single_tour|
      if single_tour.tourreferents.find_not_paid_for_referent(referent_id, single_tour.id)
        detours << single_tour
      end
    end
    detours
  end
  
  #TODO refactor
  def self.set_paid(beginning_of_month, referent_id)
    month_end = beginning_of_month.end_of_month
    all_results = find(:all, :conditions => "thedate >= '" + beginning_of_month.to_s + "' AND thedate <= '" + month_end.to_s + "' AND status = 'bestätigt'")
    all_results.each do |single_tour|
      tourreferent = single_tour.tourreferents.find_by_referent_id(referent_id)
      if tourreferent.paid == 'nein'
        changed_by = 'automatic generated bill for ' + beginning_of_month.to_s
        #tourreferent.update_attributes(:paid => 'ja', :changed_by => changed_by, :changed_on => Time.now)
      end
    end
  end
  
  private
  #TODO not used currently
  def grade_more8
    return true unless self.new_record?
    return true if ['eng', 'fr', 'it'].include?(formular)
    str = self.schoolgrade
    if str.match(/([\D]|^|\A)[1-8]([\D]|$|\z)/)
      errors.add(:schoolgrade, " Bitte beachten Sie: Mindestalter ist 14 Jahre")
    end
  end
end
