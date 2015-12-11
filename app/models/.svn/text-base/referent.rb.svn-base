class Referent < ActiveRecord::Base
  include ApplicationHelper
  LANGUAGES = ["Arabisch", "Deutsch", "Englisch", "Finnisch", "Französisch", "Griechisch",
    "Hebräisch", "Italienisch", "Japanisch", "Polnisch", "Russisch", "Slowakisch",
    "Slovenisch", "Spanisch", "Tschechisch"]

  has_many :tourreferents, :dependent => :destroy
  has_many :detours, :through => :tourreferents
  
  has_many :tsreferents, :dependent => :destroy
  has_many :ts_requests, :through => :tsreferents
  
  has_many :htsreferents, :dependent => :destroy
  has_many :htseminars, :through => :htsreferents
  
  has_many :workreferents, :dependent => :destroy
  has_many :workshops, :through => :workreferents
  
  has_many :opentourrefs, :dependent => :destroy
  has_many :opentours, :through => :opentourrefs
  
  has_many :opentourwishes, :dependent => :destroy
  has_many :opentour_wishes, :through => :opentourwishes, :source => :opentour

  validates_presence_of     :lastname,
      :message => "Nachname darf nicht leer sein!"
  validates_presence_of     :gender,
      :message => "Bitte die Anrede auswählen!"
 
  validates_presence_of     :tel, :if => "email.blank?" ,
      :message => "Geben Sie bitte eine Telefonnummer oder eine g&uuml;ltige E-Mail-Adresse  ein."
   
  validates_format_of     :email, :with => /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => "tel.blank?",
     :message => "Geben Sie bitte eine g&uuml;ltige E-Mail-Adresse oder eine Telefonnummer ein."
   
  def self.find_active_referents
    find_all_by_aktiv("aktiv", :order=> "lastname, firstname" )
  end
  
  def self.find_inactive_referents
    find_all_by_aktiv("inaktiv", :order=> "lastname, firstname" )
  end
  
  def self.find_all_except_inaktiv
    find(:all, :conditions => [ "aktiv <> 'inaktiv'"], :order=> "lastname, firstname")
  end
  
  def self.find_by_name(lastname, firstname)
    find_by_lastname_and_firstname(lastname, firstname)
  end
  
  def self.create_all_invoices(beginning_of_month)
    mycommand1 = ""
    mycommand1 << "rm public/bill/referent_bill/*/*.* -f"
    Kernel.system mycommand1

    find_all_by_honorar(true).each do |referent|
      detours = referent.detours.find_for_month(beginning_of_month, referent.id)
      ts_requests = referent.ts_requests.find_for_month(beginning_of_month, referent.id)
      htseminars = referent.htseminars.find_for_month(beginning_of_month, referent.id)
      opentours = referent.opentours.find_for_month(beginning_of_month, referent.id)
      workshops = referent.workshops.find_for_month(beginning_of_month, referent.id)

      if detours.any? or ts_requests.any? or htseminars.any? or opentours.any? or workshops.any?
        referent.create_html_file(detours, ts_requests, htseminars , opentours, workshops, beginning_of_month)
      end
    end

    mycommand2 = "tar cvzf public/bill/referent_bill/pdf/#{ Time.now.year }_#{Time.now.month}.tgz public/bill/referent_bill/pdf/*.pdf"
    Kernel.system mycommand2
    new_file = "#{RAILS_ROOT}/public/bill/referent_bill/pdf/#{ Time.now.year }_#{Time.now.month}.tgz"
    File.exists?(new_file) ? true : false
  end
  
  def create_html_file(detours, ts_requests, htseminars , opentours, workshops, beginning_of_month)
    @sum = 0
    @sum += detours.size * 65
    @sum += ts_requests.size * 150
    @sum += htseminars.size * 100
    @sum += workshops.size * 65  
    opentours.each { |opentour| (opentour.participnumber.to_i > 0)? (@sum += 65) : (@sum += 15) }
    
    identifier = "#{self.id}_#{ Time.now.year }_#{Time.now.month}"
    month = get_full_germ_month(beginning_of_month)
    year = beginning_of_month.year
    view = ActionView::Base.new(Rails::Configuration.new.view_path, 
      {:referent => self, :opentours => opentours, :detours => detours, :ts_requests => ts_requests,
       :htseminars => htseminars, :workshops => workshops, :sum => @sum, :month => month, :year => year }
    )
    class << view  
      include ApplicationHelper  
    end
    html_string = view.render(:partial => "referents/invoice")
    File.open("#{RAILS_ROOT}/public/bill/referent_bill/html/#{ identifier }_rechnung.html", "w") { |file| file.write(html_string) }

    mycommand = ""
    mycommand << " htmldoc --webpage -f"
    mycommand << " public/bill/referent_bill/pdf/" + identifier.to_s + "_rechnung.pdf"
    mycommand << " public/bill/referent_bill/html/" + identifier.to_s + "_rechnung.html"
    Kernel.system mycommand
  end
  
  def self.mark_events_as_paid(beginning_of_month)
      all.each do |referent|
        referent.detours.set_paid(beginning_of_month, referent.id)
        referent.ts_requests.set_paid(beginning_of_month, referent.id)
        referent.htseminars.set_paid(beginning_of_month, referent.id)
        referent.opentours.set_paid(beginning_of_month, referent.id)
        referent.workshops.set_paid(beginning_of_month, referent.id)
      end
  end
  
end
