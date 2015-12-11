# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def admin?
    logged_in? and current_user.role == 'admin'
  end
  
  def dbuser?
    logged_in? and current_user.role == 'dbuser'
  end
  
  def reader?
    logged_in? and current_user.role == 'reader'
  end
  
  def accounter?
    logged_in? and current_user.role == 'accounter'
  end
  
  def referee?
    lasname = current_user.lastname
    firstname = current_user.firstname
    referent = Referent.find_by_lastname_and_firstname(lasname, firstname)
    logged_in? and current_user.role == 'referee' and referent.aktiv == 'aktiv'
  end
  
  def non_aktiv_referee?
    lasname = current_user.lastname
    firstname = current_user.firstname
    referent = Referent.find_by_lastname_and_firstname(lasname, firstname)
    logged_in? and current_user.role == 'referee' and referent.aktiv == 'inaktiv'
  end
  
  def get_themen_type(theme_type)
      (theme_type == 'Theme') ? 'Themenführung' : theme_type
  end
  
  def change_umlaut(text)
    return nil unless text
    text=  text.gsub(/ö/,"&ouml;")
    text=  text.gsub(/ü/,"&uuml;")
    text=  text.gsub(/ä/,"&auml;")
    text=  text.gsub(/ß/,"&szlig;")
    text=  text.gsub(/Ö/,"&Ouml;")
    text=  text.gsub(/Ü/,"&Uuml;")
    text=  text.gsub(/Ä/,"&Auml;")
    text=  text.gsub(/€/,"&euro;")
    text=  text.gsub(/"/,"&quot;")
    text=  text.gsub(/è/,"&egrave;")
    text=  text.gsub(/é/,"&eacute;")
    text=  text.gsub(/à/,"&agrave;")
    text=  text.gsub(/á/,"&aacute;")
    text=  text.gsub(/ô/,"&#244;")
    text = text.gsub(/°/, "&deg;")
    text = text.gsub(/’/, "&#39;")
  end

  def change_date(datum)
    if !datum.blank? then
      datum.strftime("%d.%m.%Y")
    end
  end
  
  def change_time(time)
    if !time.blank? then
      time.strftime("%H:%M")
    end
  end
  
  def get_day(datum)
    if !datum.blank? then
      datum.strftime("%a")
    end
  end
 
  def get_vollday(datum)
    if !datum.blank? then
      datum.strftime("%A")
    end
  end
 
  def get_engl_day(datum)
    if !datum.blank?
      day = datum.strftime("%a")
      if day == 'Mo' or day == 'Lun' then day_eng = 'Mon'
      elsif day == 'Di' or day == 'Mar' then day_eng = 'Tue'
      elsif day == 'Mi' or day == 'Mer' then day_eng = 'Wed'
      elsif day == 'Do' or day == 'Gio' then day_eng = 'Thu'
      elsif day == 'Fr' or day == 'Ven' then day_eng = 'Fri'
      elsif day == 'Sa' or day == 'Sab' then day_eng = 'Sat'
      elsif day == 'So' or day == 'Dom' then day_eng = 'Sun' 
      end
    end
    day_eng
  end
 
  def get_german_day(datum)
    if !datum.blank? then
      day = datum.strftime("%a")
      if day == 'Mo' or day == 'Mon' or day == 'Lun' then day_german = 'Mo'
      elsif day == 'Di' or day == 'Tue' or day == 'Mar' then day_german = 'Di'
      elsif day == 'Mi' or day == 'Wed' or day == 'Mer' then day_german = 'Mi'
      elsif day == 'Do' or day == 'Thu' or day == 'Gio' then day_german = 'Do'
      elsif day == 'Fr' or day == 'Fri' or day == 'Ven' then day_german = 'Fr'
      elsif day == 'Sa' or day == 'Sat' or day == 'Sab' then day_german = 'Sa'
      elsif day == 'So' or day == 'Sun' or day == 'Dom' then day_german = 'So' 
      end
    end
    day_german
  end
 
 
  def get_fullenglday(datum)
    if !datum.blank? then
      day = datum.strftime("%a")
      if day == 'Mo' or day == 'Mon' or day == 'Lun' then day_eng = 'Monday'
      elsif day == 'Di' or day == 'Tue' or day == 'Mar' then day_eng = 'Tuesday'
      elsif day == 'Mi' or day == 'Wed' or day == 'Mer' then day_eng = 'Wednesday'
      elsif day == 'Do' or day == 'Thu' or day == 'Gio' then day_eng = 'Thursday'
      elsif day == 'Fr' or day == 'Fri' or day == 'Ven' then day_eng = 'Friday'
      elsif day == 'Sa' or day == 'Sat' or day == 'Sab' then day_eng = 'Saturday'
      elsif day == 'So' or day == 'Sun' or day == 'Dom' then day_eng = 'Sunday' 
      end
    end
    day_eng
  end
  
  def get_fullitday(datum)
    if !datum.blank? then
      day = datum.strftime("%a")
      if day == 'Mo' or day == 'Mon' or day == 'Lun' then day_eng = 'lunedì'
      elsif day == 'Di' or day == 'Tue' or day == 'Mar' then day_eng = 'martedì'
      elsif day == 'Mi' or day == 'Wed' or day == 'Mer' then day_eng = 'mercoledì'
      elsif day == 'Do' or day == 'Thu' or day == 'Gio' then day_eng = 'giovedì'
      elsif day == 'Fr' or day == 'Fri' or day == 'Ven' then day_eng = 'venerdì'
      elsif day == 'Sa' or day == 'Sat' or day == 'Sab' then day_eng = 'sabato'
      elsif day == 'So' or day == 'Sun' or day == 'Dom' then day_eng = 'domenica' 
      end
    end
    day_eng
  end
  
  def get_full_it_day(datum)
    if !datum.blank? then
      day = datum.strftime("%a")
      if day == 'Mo' or day == 'Mon' or day == 'Lun' then day_eng = 'lunedì'
      elsif day == 'Di' or day == 'Tue' or day == 'Mar' then day_eng = 'martedì'
      elsif day == 'Mi' or day == 'Wed' or day == 'Mer' then day_eng = 'mercoledì'
      elsif day == 'Do' or day == 'Thu' or day == 'Gio' then day_eng = 'giovedì'
      elsif day == 'Fr' or day == 'Fri' or day == 'Ven' then day_eng = 'venerdì'
      elsif day == 'Sa' or day == 'Sat' or day == 'Sab' then day_eng = 'sabato'
      elsif day == 'So' or day == 'Sun' or day == 'Dom' then day_eng = 'domenica' 
      end
    end
    day_eng
  end
  
  def get_full_fr_day(datum)
    if !datum.blank? then
      day = datum.strftime("%a")
      if day == 'Mo' or day == 'Mon' or day == 'Lun' then day_fr = 'lundi'
      elsif day == 'Di' or day == 'Tue' or day == 'Mar' then day_fr = 'mardi'
      elsif day == 'Mi' or day == 'Wed' or day == 'Mer' then day_fr = 'mercredi'
      elsif day == 'Do' or day == 'Thu' or day == 'Gio' then day_fr = 'jeudi'
      elsif day == 'Fr' or day == 'Fri' or day == 'Ven' then day_fr = 'vendredi'
      elsif day == 'Sa' or day == 'Sat' or day == 'Sab' then day_fr = 'samedi'
      elsif day == 'So' or day == 'Sun' or day == 'Dom' then day_fr = 'dimanche' 
      end
    end
    day_fr
  end

  def get_full_germ_day(datum)
    if !datum.blank? then
      day = datum.strftime("%a")
      if day == 'Mo' or day == 'Mon' or day == 'Lun' then day_german = 'Montag'
      elsif day == 'Di'or day == 'Tue' or day == 'Mar' then day_german = 'Dienstag'
      elsif day == 'Mi' or day == 'Wed' or day == 'Mer' then day_german = 'Mittwoch'
      elsif day == 'Do' or day == 'Thu' or day == 'Gio' then day_german = 'Donnerstag'
      elsif day == 'Fr' or day == 'Fri' or day == 'Ven' then day_german = 'Freitag'
      elsif day == 'Sa' or day == 'Sat' or day == 'Sab' then day_german = 'Samstag'
      elsif day == 'So' or day == 'Sun' or day == 'Dom' then day_german = 'Sonntag' 
      end
    end
    day_german
  end  
  
  def get_full_germ_month(datum)
    if datum.instance_of?(Fixnum) or datum.instance_of?(String)
      m = datum.to_s
    elsif !datum.blank? 
      m = datum.strftime("%m")
    end
    m_german = 'Januar' if m == '01'
    m_german = 'Februar' if m == '02'
    m_german = 'März' if m == '03'
    m_german = 'April' if m == '04'
    m_german = 'Mai' if m == '05'
    m_german = 'Juni' if m == '06'
    m_german = 'Juli' if m == '07'
    m_german = 'August' if m == '08'
    m_german = 'September' if m == '09'
    m_german = 'Oktober' if m == '10'                             
    m_german = 'November' if m == '11'
    m_german = 'Dezember' if m == '12'
    m_german
  end  
 
  def get_output_germ_date(datum)
    datum.strftime("%d")+'. '+ get_full_germ_month(datum)+' '+datum.strftime("%Y")
  end
  
  def get_language_de(language)   
    lang = "Arabisch" if (language=="Arabisch" or language=="Arabic" or language=="Arabo" or language == "Arabe") 
    lang = "Englisch" if (language=="Englisch" or language=="English" or language=="Inglese" or language == "Anglais") 
    lang = "Deutsch" if(language=="Deutsch" or language=="German" or language=="Tedesco" or language == "Allemand")
    lang = "Finnisch" if(language=="Finnisch" or language=="Finnish" or language=="Finlandese" or language == "Finlandais")
    lang = "Französisch" if(language=="Französisch" or language=="French" or language=="Francese" or language == "Français")
    lang = "Griechisch" if(language=="Griechisch" or language=="Greek" or language=="Greco" or language == "Grec")
    lang = "Hebräisch" if(language=="Hebräisch" or language=="Hebrew" or language=="Ebraico" or language == "Hébreu")
    lang = "Italienisch" if(language=="Italienisch" or language=="Italian" or language=="Italiano" or language == "Italien")
    lang = "Japanisch" if(language=="Japanisch" or language=="Japanese" or language=="Giapponese Polacco" or language == "Japonais")
    lang = "Polnisch" if(language=="Polnisch" or language=="Polish" or language == "Polacco" or language == "Polonais") 
    lang = "Russisch" if(language=="Russisch" or language=="Russian" or language=="Russo" or language == "Russe") 
    lang = "Slowakisch" if(language=="Slowakisch" or language=="Slovakian" or language=="Slovacco" or language == "Slovaque")
    lang = "Slovenisch" if(language=="Slovenisch" or language=="Slovenian")
    lang = "Spanisch" if(language=="Spanisch" or language=="Spanish" or language=="Spagnolo" or language == "Espagnol")
    lang = "Tschechisch" if(language=="Tschechisch"  or language=="Czech" or language=="Ceco" or language == "Tchèque") 
    lang
  end
  
    def get_language_eng(language)   
    lang = "Arabic" if (language=="Arabisch" or language=="Arabic" or language=="Arabo") 
    lang = "English" if (language=="Englisch" or language=="English" or language=="Inglese") 
    lang = "German" if(language=="Deutsch" or language=="German" or language=="Tedesco")
    lang = "Finnish" if(language=="Finnisch" or language=="Finnish" or language=="Finlandese")
    lang = "French" if(language=="Französisch" or language=="French" or language=="Francese")
    lang = "Greek" if(language=="Griechisch" or language=="Greek" or language=="Greco")
    lang = "Hebrew" if(language=="Hebräisch" or language=="Hebrew" or language=="Ebraico")
    lang = "Italian" if(language=="Italienisch" or language=="Italian" or language=="Italiano")
    lang = "Japanese" if(language=="Japanisch" or language=="Japanese" or language=="Giapponese Polacco")
    lang = "Polish" if(language=="Polnisch" or language=="Polish" or language=="Polish") 
    lang = "Russian" if(language=="Russisch" or language=="Russian" or language=="Russo") 
    lang = "Slovakian" if(language=="Slowakisch" or language=="Slovakian" or language=="Slovacco")
    lang = "Slovenian" if(language=="Slovenisch" or language=="Slovenian" or language=="Slovenian")
    lang = "Spanish" if(language=="Spanisch" or language=="Spanish" or language=="Spagnolo")
    lang = "Czech" if(language=="Tschechisch"  or language=="Czech" or language=="Ceco") 
    lang
  end
  
  def get_language_it(language)   
    lang = "Arabo" if (language == "Arabic" or language=="Arabisch" or language=="Arabic") 
    lang = "Inglese" if (language=="Englisch" or language=="English" or language=="English") 
    lang = "Tedesco" if(language=="Deutsch" or language=="German" or language=="German")
    lang = "Finlandese" if(language=="Finnisch" or language=="Finnish" or language=="Finnish")
    lang = "Francese" if(language=="Französisch" or language=="French" or language=="French")
    lang = "Greco" if(language=="Griechisch" or language=="Greek" or language=="Greek")
    lang = "Ebraico" if(language=="Hebräisch" or language=="Hebrew" or language=="Hebrew")
    lang = "Italiano" if(language=="Italienisch" or language=="Italian" or language=="Italian")
    lang = "Giapponese Polacco" if(language=="Japanisch" or language=="Japanese" or language=="Japanese")
    lang = "Polish" if(language=="Polnisch" or language=="Polish" or language=="Polish") 
    lang = "Russo" if(language=="Russisch" or language=="Russian" or language=="Russian") 
    lang = "Slovacco" if(language=="Slowakisch" or language=="Slovakian" or language=="Slovakian")
    lang = "Slovenian" if(language=="Slovenisch" or language=="Slovenian" or language=="Slovenian")
    lang = "Spagnolo" if(language=="Spanisch" or language=="Spanish" or language=="Spanish")
    lang = "Ceco" if(language=="Tschechisch"  or language=="Czech" or language=="Czech") 
    lang
  end
  
  def get_language_fr(language)   
    lang = "Arabe" if (language=="Arabisch" or language=="Arabic" or language=="Arabo" or language == "Arabe") 
    lang = "Anglais" if (language=="Englisch" or language=="English" or language=="Inglese" or language == "Anglais") 
    lang = "Allemand" if(language=="Deutsch" or language=="German" or language=="Tedesco" or language == "Allemand")
    lang = "Finlandais" if(language=="Finnisch" or language=="Finnish" or language=="Finlandese" or language == "Finlandais")
    lang = "Français" if(language=="Französisch" or language=="French" or language=="Francese" or language == "Français")
    lang = "Grec" if(language=="Griechisch" or language=="Greek" or language=="Greco" or language == "Grec")
    lang = "Hébreu" if(language=="Hebräisch" or language=="Hebrew" or language=="Ebraico" or language == "Hébreu")
    lang = "Italien" if(language=="Italienisch" or language=="Italian" or language=="Italiano" or language == "Italien")
    lang = "Japonais" if(language=="Japanisch" or language=="Japanese" or language=="Giapponese Polacco" or language == "Japonais")
    lang = "Polonais" if(language=="Polnisch" or language=="Polish" or language == "Polacco" or language == "Polonais") 
    lang = "Russe" if(language=="Russisch" or language=="Russian" or language=="Russo" or language == "Russe") 
    lang = "Slovaque" if(language=="Slowakisch" or language=="Slovakian" or language=="Slovacco" or language == "Slovaque")
    lang = "Slovenisch" if(language=="Slovenisch" or language=="Slovenian")
    lang = "Espagnol" if(language=="Spanisch" or language=="Spanish" or language=="Spagnolo" or language == "Espagnol")
    lang = "Tchèque" if(language=="Tschechisch"  or language=="Czech" or language=="Ceco" or language == "Tchèque") 
    lang
  end

  def get_film_de(film)
    if (film =="ja" or film=="yes" or film == "sì") then "ja" else "nein"
    end
  end
 
  def get_havebeen_de(havebeen)
    if (havebeen =="ja" || havebeen == "yes" || havebeen == "sì") then "ja" 
    elsif (havebeen =="nein" || havebeen =="no") then "nein"
    else "zum Teil"
    end
  end
 
 
  def format_paid_attr(paid)
    if (paid == "ja,überwiesen")
      return "überw."
    else
      return paid
    end  
  end
  
  def get_file_if_exists(event, event_id)
    filename = nil
    if event == "detour"
      if File.exists?("#{RAILS_ROOT}/public/bill/pdf/R#{event_id}_bill.pdf")
        filename = "R#{event_id}_bill.pdf"
      elsif File.exists?("#{RAILS_ROOT}/public/bill/pdf/RE#{event_id}_bill.pdf")
        filename = "RE#{event_id}_bill.pdf"
      end
    end
    
    if event == "htseminar"
      if File.exists?("#{RAILS_ROOT}/public/bill/pdf/HTS#{event_id}_bill.pdf")
        filename = "HTS#{event_id}_bill.pdf"
      elsif File.exists?("#{RAILS_ROOT}/public/bill/pdf/HTSE#{event_id}_bill.pdf")
        filename = "HTSE#{event_id}_bill.pdf"
      end
    end
    
    if event == "ts_request"
      if File.exists?("#{RAILS_ROOT}/public/bill/pdf/TS#{event_id}_bill.pdf")
        filename = "TS#{event_id}_bill.pdf"
      end
    end
    
    if event == "workshop"
      if File.exists?("#{RAILS_ROOT}/public/bill/pdf/W#{event_id}_bill.pdf")
        filename = "W#{event_id}_bill.pdf"
      end
    end
    
    filename
  end

  def number_to_euro(number)
    number_to_currency(number, :unit => "", :separator => ",", :delimiter => "", :format => "%n %u")
  end  
  
  def rationing
    "Die Verpflegung der Teilnehmer (Mittagessen) kann auf Wunsch von uns organisiert werden. Das Mittagessen könnte in der Cafeteria des Besucherzentrums eingenommen werden und würde Sie pro Person 6,30.-€ kosten."
  end
  
  def detours_without_referent_email
    Tourreferent.confirmed_without_referent_mail.map(&:detour).uniq
  end
  
  def ts_requests_without_referent_email
    Tsreferent.confirmed_without_referent_mail.map(&:ts_request).uniq
  end
  
  def htseminars_without_referent_email
    Htsreferent.confirmed_without_referent_mail.map(&:htseminar).uniq
  end
  
  def workshops_without_referent_email
    Workreferent.confirmed_without_referent_mail.map(&:workshop).uniq
  end
  
  def opentours_without_referent_email
    Opentourref.confirmed_without_referent_mail.map(&:opentour).uniq
  end
  
  def any_unsent_emails?
    return true if detours_without_referent_email.any?
    return true if ts_requests_without_referent_email.any?
    return true if htseminars_without_referent_email.any? 
    return true if workshops_without_referent_email.any?
    return true if opentours_without_referent_email.any?
    false
  end
  
  def denial_date(event)
    date = event.date1.strftime("%d.%m.%Y ")
    date << event.from1.strftime("%H:%M")
    if event.respond_to?(:date2) and !event.date2.blank?
      date << ", "
      date << event.date2.strftime("%d.%m.%Y ")
      date << event.from2.strftime("%H:%M")
    end
    if event.respond_to?(:date3) and !event.date3.blank?
      date << ", "
      date << event.date3.strftime("%d.%m.%Y ")
      date << event.from3.strftime("%H:%M")
    end
    date
  end
  
  def get_engl_gender(gender)
    if ['Miss',  'Mrs.', 'Mrs', 'Mr', 'Mr.', 'Ms'].include?(gender)
      return gender
    elsif gender.starts_with?('Fr') 
      return 'Mrs.'
    elsif gender == 'Signora'
      return 'Mrs.'
    elsif (gender.starts_with?('Herr') or gender.starts_with?('Hr')) or gender == 'Signor'
      return 'Mr.'
    else 
      return gender
    end
  end
  
  def get_it_gender(gender)
    if ['Miss',  'Mrs.', 'Mrs', 'Ms', 'Fr', 'Fr.', 'Frau', 'Signora'].include?(gender)
      return 'Signora'
    elsif ['Mr.', 'Mr', 'Herr', 'Hr', 'Signor'].include?(gender)
      return 'Signor'
    else 
      return gender
    end
  end
  
  def get_de_gender(gender)
    if ['Miss',  'Mrs.', 'Mrs', 'Mr', 'Mr.', 'Ms', 'Fr', 'Fr.', 'Frau', 'Signora'].include?(gender)
      return 'Frau'
    elsif ['Herr', 'Hr', 'Hr.', 'Mr', 'Mr.', 'Signor'].include?(gender)
      return 'Herr'
    else 
      return gender
    end
  end
  
  def get_event_time(event)
    if event.class == Opentour
      change_time(event.time)
    else 
      change_time(event.thefrom) + "-" + change_time(event.theto)
    end
  end
  
  def get_german_event_name(event)
    case event
    when Detour
      return "Rundgang"
    when TsRequest
      return "Tagesseminar"
    when Htseminar
      return "Halbtagesseminar"
    when Opentour
      return "Offene Führung"
    else
      return event.class.name
    end
  end
  
  def check_event_mail_send(event, eventref)
    if event.class != Opentour
      if eventref.mailsend == 0
        return "nein"
      else
        eventref.maildate
      end
    end
  end
  
  def get_eventref(event, referent)
    if event.class == Detour
      eventref = Tourreferent.find_by_detour_id_and_referent_id(event.id, referent.id)
    elsif event.class == Htseminar
      eventref = Htsreferent.find_by_htseminar_id_and_referent_id(event.id, referent.id)
    elsif event.class == TsRequest
      eventref = Tsreferent.find_by_ts_request_id_and_referent_id(event.id, referent.id)
    elsif event.class == Workshop
      eventref = Workreferent.find_by_workshop_id_and_referent_id(event.id, referent.id)
    elsif event.class == Opentour
      eventref = event.opentourref
    end
    eventref
  end
  
  def events_options_for_select
    [['alle', 'all'], ['Rundgang', 'detour'], ['Tagesseminar', 'tsrequest'], ['Halbtagesseminar', 'htseminar'], ['Offene Führung', 'opentour'], ['Workshop', 'workshop']]
  end
  
  def get_input_language(formular)
    case formular
    when 'ger'
      'Deutsch'
    when 'it'
      'Italienisch'
    when 'fr'
      'Französisch'
    when 'eng'
      'Englisch'
    else
      formular
    end
  end
end