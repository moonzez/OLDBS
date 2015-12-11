class RequestMailer < ActionMailer::Base
  
  def result_email(tour, sent_at = Time.now)
    if tour.themetour
      if (tour == "Exkursion")
        @subject = 'Ihre Anfrage zur Exkursion am '+tour.date1.strftime("%d.%m.%Y")
      else
        @subject = 'Ihre Anfrage zur Themenführung am '+tour.date1.strftime("%d.%m.%Y")
      end
    else
      @subject = 'Ihre Reservierung für den Rundgang am '+tour.date1.strftime("%d.%m.%Y")
    end
    @body ["tour"] = tour
    @recipients = tour.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def result_email_eng(tour, sent_at = Time.now)
    @subject = "Your request regarding a guided tour through the CC-Memorial Dachau on "+ tour.date1.strftime("%d.%m.%Y")
    @body ["tour"] = tour
    @recipients = tour.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def result_email_fr(tour, sent_at = Time.now)
    @subject = "Votre réservation pour la visite du "+ tour.date1.strftime("%d.%m.%Y")
    @body ["tour"] = tour
    @recipients = tour.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def result_email_it(tour, sent_at = Time.now)
    @subject = "La Vostra richiesta per una visita guidata del memoriale del campo di concentramento il "+ tour.date1.strftime("%d.%m.%Y")
    @body ["tour"] = tour
    @recipients = tour.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def workshop_result(work, sent_at = Time.now)
    @subject = 'Ihre Reservierung für den Workshop am '+work.date1.strftime("%d.%m.%Y")
    @body ["work"] = work
    @recipients = work.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def ts_result(ts, sent_at = Time.now)
    @subject = 'Ihre Reservierung für den Tagesseminar am '+ts.date1.strftime("%d.%m.%Y")
    @body ["ts"] = ts
    @recipients = ts.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def hts_result(hts, sent_at = Time.now)
    @subject = 'Ihre Reservierung für den Halbtagesseminar am '+hts.date1.strftime("%d.%m.%Y")
    @body ["htseminar"] = hts
    @recipients = hts.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def htseng_result(hts, sent_at = Time.now)
    @subject = "Your request regarding a half-day seminar on "+ hts.date1.strftime("%d.%m.%Y")
    @body ["htseminar"] = hts
    @recipients = hts.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def htsit_result(hts, sent_at = Time.now)
    @subject = "La Vostra richiesta di prenotazione per un seminario di mezza giornata il "+ hts.date1.strftime("%d.%m.%Y")
    @body ["htseminar"] = hts
    @recipients = hts.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def htsfr_result(hts, sent_at = Time.now)
    @subject = "Your request regarding a half-day seminar on "+ hts.date1.strftime("%d.%m.%Y")
    @body ["htseminar"] = hts
    @recipients = hts.email
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  ###########    Referenten    ################
 
  def referent_tour(tour, referent, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
    
    attachment "application/pdf" do |a|
      a.filename = File.basename("Anfrage_Rundgang.pdf")
      File.open("public/buchung/pdf/detours/#{tour.id}_tour.pdf", 'rb') { |file| a.body = file.read }
    end
  end
 
  def referent_ts(ts, referent, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
    
    attachment "application/pdf" do |a|
      a.filename = File.basename("Anfrage_Tagesseminar.pdf")
      File.open("public/buchung/pdf/ts_requests/#{ts.id}_ts.pdf", 'rb') { |file| a.body = file.read }
    end
  end
  
    def referent_hts(hts, referent, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    attachment "application/pdf" do |a|
      a.filename = File.basename("Anfrage_Halbtagesseminar.pdf")
      File.open("public/buchung/pdf/hts/#{hts.id}_hts.pdf", 'rb') { |file| a.body = file.read }
    end
  end
  
    def referent_work(work, referent, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty? 
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
    
    attachment "application/pdf" do |a|
      a.filename = File.basename("Anfrage_Workshop.pdf")
      File.open("public/buchung/pdf/workshops/#{work.id}_work.pdf", 'rb') { |file| a.body = file.read }
    end
  end
  
  def referent_otour(referent, subject, mail_text, sent_at = Time.now)
    @subject = subject
    @body = mail_text
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  ################### Referenten Absage der Veranstaltung #####################
  
  def not_detour(tour, referent, ref_text, sent_at = Time.now)
    @subject = "Absage: Rundgang am "+tour.thedate.strftime("%d.%m.%Y")
    @body = ref_text
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def not_ts(ts, referent, sent_at = Time.now)
    @subject = "Absage: Tagesseminar am "+ts.thedate.strftime("%d.%m.%Y")
    @body = "Das Tagesseminar am "+ts.thedate.strftime("%d.%m.%Y")+" um "+ts.thefrom.strftime("%H:%M")+" wird nicht stattfinden."
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def not_hts(hts, referent, text, sent_at = Time.now)
    @subject = "Stornierung - Halbtagesseminar am "+hts.thedate.strftime("%d.%m.%Y")
    @body = text
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end

  def not_work(work, referent, sent_at = Time.now)
    @subject = "Absage: Workshop am "+work.thedate.strftime("%d.%m.%Y")
    @body = "Der Workshop am "+work.thedate.strftime("%d.%m.%Y")+" um "+work.thefrom.strftime("%H:%M")+" wird nicht stattfinden."
    @recipients = [referent.email, 'buchungen@kz-gedenkstaette-dachau.de']
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
    
  ###################   Absagen    ###################
  
  def denial_tour(tour, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def denial_toureng(tour, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty? 
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def denial_tourit(tour, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty? 
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def denial_tourfr(tour, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty? 
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def denial_ts(ts, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [ts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def denial_hts(hts, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def denialit_hts(hts, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def denial_workshop(workshop, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [workshop.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  ##################     Stornierung ##################################
  
  def storno_tour(tour, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def stornoeng_tour(tour, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def stornoit_tour(tour, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def stornofr_tour(tour, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def storno_hts(hts, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def stornoeng_hts(hts, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def stornoit_hts(hts, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def storno_ts(ts, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [ts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  def storno_workshop(workshop, betreff, text, cc, sent_at = Time.now)
    @subject = betreff
    @body = text
    @recipients = [workshop.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty? 
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
  
  ##################     Zusagen     ##################################
  
  def zusagefull_tour(tour, bill_file, betref, text, cc, sent_at = Time.now)  
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?    
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/Infos.pdf"]
    if tour.current_fee == 70.00
      formulars << "form/Gebuehrenordnung.pdf"
    else
      formulars << "form/Gebuehrenordnung_01042016.pdf"
    end
    formulars += [bill_file, "form/Besucherordnung.pdf"]
    
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Informationen.pdf" if @nummer == 0
        a.filename = "Gebuehrenordnung.pdf" if @nummer == 1
        a.filename = "Rechnung_vom_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2
        a.filename = "Besucherordnung.pdf" if @nummer == 3
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  
    attachment "application/msword" do |d|
      d.filename =  File.basename("Fragebogen_Gedenkstaettenbesuch.doc")
      file_path = "form/Fragebogen_Gedenkstaettenbesuch.doc"
      if tour.themetour
        if (tour.theme_type == 'Theme')
          file_path = "form/Fragebogen_Gedenkstaettenbesuch_Theme.doc"
        else
          file_path = "form/Fragebogen_Gedenkstaettenbesuch_Exkursion.doc"
        end 
      end
      File.open(file_path, 'rb') { |file| d.body = file.read }
    end    
  end
  
  def zusagefullohnebill_tour(tour, betref, text, cc, sent_at = Time.now)  
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?  
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    
    formulars = ["form/Infos.pdf", "form/Besucherordnung.pdf"]

    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Informationen.pdf" if @nummer == 0
        a.filename = "Besucherordnung.pdf" if @nummer == 1
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  
    attachment "application/msword" do |d|
      d.filename =  File.basename("Fragebogen_Gedenkstaettenbesuch.doc")   
      File.open("form/Fragebogen_Gedenkstaettenbesuch.doc", 'rb') { |file| d.body = file.read }
    end    
  end
  
  def zusagefulleng_tour(tour, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

   formulars = ["form/EngInfo.pdf"]
    if tour.current_fee == 70.00
      formulars << "form/Scale_of_charges.pdf"
    else
      formulars << "form/Scale_of_charges_01042016.pdf"
    end
    formulars += [bill_file, "form/Guidelines_for_visitors.pdf"]
    
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Information.pdf" if @nummer == 0
        a.filename = "Scale_of_charges.pdf" if @nummer == 1
        a.filename = "Bill_from_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2
        a.filename = "Guidelines_for_visitors.pdf" if @nummer == 3
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  end
  
  def zusagefullit_tour(tour, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/EngInfo.pdf"]
    if tour.current_fee == 70.00
      formulars << "form/Tariffario.pdf"
    else
      formulars << "form/Tariffario_01042016.pdf"
    end
    formulars += [bill_file, "form/Regolamento_per_i_visitatori.pdf"]
    
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Informazioni.pdf" if @nummer == 0
        a.filename = "Tariffario.pdf" if @nummer == 1
        a.filename = "Fattura_del_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2
        a.filename = "Regolamento_per_i_visitatori.pdf" if @nummer == 3
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  end
  
  def zusagefullfr_tour(tour, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/EngInfo.pdf"]
    if tour.current_fee == 70.00
      formulars << "form/Tarifs.pdf"
    else
      formulars << "form/Tarifs_01042016.pdf"
    end
    formulars += [bill_file, "form/Reglement_pour_les_visiteurs.pdf"]
    
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Information.pdf" if @nummer == 0
        a.filename = "Tarifs.pdf" if @nummer == 1
        a.filename = "Facture_le_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2
        a.filename = "Reglement_pour_les_visiteurs.pdf" if @nummer == 3
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
    
    attachment 'application/msword' do |attach|
      attach.filename = File.basename("Guestionnaire.doc")
      file_path = "form/Fragebogen_Gedenkstaettenbesuch_FR.doc"
      File.open(file_path, 'rb') { |file| attach.body = file.read }
    end
  end
  
  def zusagefullengohnebill_tour(tour, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/EngInfo.pdf", "form/Guidelines_for_visitors.pdf"]

    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Information.pdf" if @nummer == 0
        a.filename = "Guidelines_for_visitors.pdf" if @nummer == 1
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  end
  
  def zusagefullfrohnebill_tour(tour, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/EngInfo.pdf", "form/Reglement_pour_les_visiteurs.pdf"]

    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Information.pdf" if @nummer == 0
        a.filename = "Reglement_pour_les_visiteurs.pdf" if @nummer == 1
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
    
    attachment 'application/msword' do |attach|
      attach.filename = File.basename("Guestionnaire.doc")
      file_path = "form/Fragebogen_Gedenkstaettenbesuch_FR.doc"
      File.open(file_path, 'rb') { |file| attach.body = file.read }
    end
  end
  
  def zusagefullitohnebill_tour(tour, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
    
    formulars = ["form/EngInfo.pdf", "form/Regolamento_per_i_visitatori.pdf"]

    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Informazioni.pdf" if @nummer == 0
        a.filename = "Regolamento_per_i_visitatori.pdf" if @nummer == 1
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  end
  
  def zusagefull_ts(ts, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [ts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
    
    formulars = ["form/Infos.pdf"]
    if ts.current_fee == 120.00
      formulars << "form/Gebuehrenordnung.pdf"
    else
      formulars << "form/Gebuehrenordnung_01042016.pdf"
    end
    formulars += [bill_file, "form/Besucherordnung.pdf"]
 
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
      a.filename = "Informationen.pdf" if @nummer == 0
      a.filename = "Gebuehrenordnung.pdf" if @nummer == 1
      a.filename = "Rechnung_vom_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2
      a.filename = "Besucherordnung.pdf" if @nummer == 3
      File.open(formular, 'rb') { |file| a.body = file.read }
      @nummer += 1
      end
    end

    attachment "application/msword" do |d|
      d.filename =  File.basename("Fragebogen_Gedenkstaettenbesuch.doc")   
      File.open("form/Fragebogen_Gedenkstaettenbesuch.doc", 'rb') { |file| d.body = file.read }
    end
  end
 
  def zusagefullohnebill_ts(ts, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [ts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/Infos.pdf", "form/Besucherordnung.pdf"]
 
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
      a.filename = "Informationen.pdf" if @nummer == 0
      a.filename = "Besucherordnung.pdf" if @nummer == 1
      File.open(formular, 'rb') { |file| a.body = file.read }
      @nummer += 1
      end
    end

    attachment "application/msword" do |d|
      d.filename =  File.basename("Fragebogen_Gedenkstaettenbesuch.doc")   
      File.open("form/Fragebogen_Gedenkstaettenbesuch.doc", 'rb') { |file| d.body = file.read }
    end
  end
  
  def zusagefull_hts(hts, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/Infos.pdf"]
    if hts.current_fee == 90.00
      formulars << "form/Gebuehrenordnung.pdf"
    else
      formulars << "form/Gebuehrenordnung_01042016.pdf"
    end
    formulars += [bill_file, "form/Besucherordnung.pdf"]
    
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
      a.filename = "Informationen.pdf" if @nummer == 0
      a.filename = "Gebuehrenordnung.pdf" if @nummer == 1
      a.filename = "Rechnung_vom_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2
      a.filename = "Besucherordnung.pdf" if @nummer == 3
      File.open(formular, 'rb') { |file| a.body = file.read }
      @nummer += 1
      end
    end
    
    attachment "application/msword" do |d|
      d.filename =  File.basename("Fragebogen_Gedenkstaettenbesuch.doc")   
      File.open("form/Fragebogen_Gedenkstaettenbesuch.doc", 'rb') { |file| d.body = file.read }
    end
  end
  
  def zusagefulleng_hts(hts, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/EngInfo.pdf"]
    if hts.current_fee == 90.00
      formulars << "form/Scale_of_charges.pdf"
    else
      formulars << "form/Scale_of_charges_01042016.pdf"
    end
    formulars += [bill_file, "form/Guidelines_for_visitors.pdf"]
    
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Information.pdf" if @nummer == 0
        a.filename = "Scale_of_charges.pdf" if @nummer == 1
        a.filename = "Bill_from_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2
        a.filename = "Guidelines_for_visitors.pdf" if @nummer == 3
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
     end
    end
  end
  
  def zusagefullit_hts(hts, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/EngInfo.pdf"]
    if hts.current_fee == 90.00
      formulars << "form/Tariffario.pdf"
    else
      formulars << "form/Tariffario_01042016.pdf"
    end
    formulars += [bill_file, "form/Regolamento_per_i_visitatori.pdf"]
    
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Informazioni.pdf" if @nummer == 0
        a.filename = "Tariffario.pdf" if @nummer == 1
        a.filename = "Fattura_del_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2
        a.filename = "Regolamento_per_i_visitatori.pdf" if @nummer == 3
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
     end
    end
  end
  
  def zusagefullengohnebill_hts(hts, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/EngInfo.pdf", "form/Guidelines_for_visitors.pdf"]

    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Information.pdf" if @nummer == 0
        a.filename = "Guidelines_for_visitors.pdf" if @nummer == 1
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  end
  
  def zusagefullitohnebill_hts(hts, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/EngInfo.pdf", "form/Regolamento_per_i_visitatori.pdf"]

    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Informazioni.pdf" if @nummer == 0
        a.filename = "Regolamento_per_i_visitatori.pdf" if @nummer == 1
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  end
  
  def zusagefullohnebill_hts(hts, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/Infos.pdf", "form/Besucherordnung.pdf"]
 
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
      a.filename = "Informationen.pdf" if @nummer == 0
      a.filename = "Besucherordnung.pdf" if @nummer == 1
      File.open(formular, 'rb') { |file| a.body = file.read }
      @nummer += 1
      end
    end
   
    attachment "application/msword" do |d|
      d.filename =  File.basename("Fragebogen_Gedenkstaettenbesuch.doc")   
      File.open("form/Fragebogen_Gedenkstaettenbesuch.doc", 'rb') { |file| d.body = file.read }
    end
  end
  
  def zusagefull_workshop(workshop, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [workshop.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/Merkblatt-Workshop.pdf"]
    if (workshop.thedate.to_date < "2016-04-01".to_date)
      formulars << "form/Gebuehrenordnung.pdf"
    else
      formulars << "form/Gebuehrenordnung_01042016.pdf"
    end
    formulars += [bill_file, "form/Besucherordnung.pdf"]
    
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
        a.filename = "Merkblatt-Workshop.pdf" if @nummer == 0
        a.filename = "Gebuehrenordnung.pdf" if @nummer == 1
        a.filename = "Rechnung_vom_"+Time.now.localtime.strftime("%Y-%m-%d")+".pdf" if @nummer == 2 
        a.filename = "Besucherordnung.pdf" if @nummer == 3
        File.open(formular, 'rb') { |file| a.body = file.read }
        @nummer += 1
      end
    end
  end
    
  def zusagefullohnebill_workshop(workshop, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [workshop.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}

    formulars = ["form/Merkblatt-Workshop.pdf", "form/Besucherordnung.pdf"]
 
    @nummer = 0
    formulars.each do |formular|
      attachment "application/pdf" do |a|
      a.filename = "Merkblatt-Workshop.pdf" if @nummer == 0
      a.filename = "Besucherordnung.pdf" if @nummer == 1
      File.open(formular, 'rb') { |file| a.body = file.read }
      @nummer += 1
      end
    end
  end
 
  ###################   Mahnung  ####################################
  
  def mahnung_tour(tour, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Rechnung_vom_"+tour.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end  
  end
  
  def mahnungeng_tour(tour, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Invoice_"+tour.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end  
  end
  
  def mahnungit_tour(tour, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Fattura_del_"+tour.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end  
  end

  def mahnungfr_tour(tour, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [tour.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Facture_le_" + tour.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end  
  end
  
  def mahnung_ts(ts, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [ts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Rechnung_vom_"+ts.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end
  end
  
  def mahnung_hts(hts, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Rechnung_vom_"+hts.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end     
  end
  
  def mahnungeng_hts(hts, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Bill_from_"+hts.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end     
  end
  
  def mahnungit_hts(hts, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [hts.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Fattura_del_"+hts.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end     
  end
 
  def mahnung_workshop(workshop, bill_file, betref, text, cc, sent_at = Time.now)
    @subject = betref
    @body = text
    @recipients = [workshop.email, 'buchungen@kz-gedenkstaette-dachau.de']
    cc.split(",").each { |email| email.strip!; @recipients << email  } if !cc.empty?
    @from = 'buchungen@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
        
    attachment "application/pdf" do |a|
      a.filename = "Rechnung_vom_"+workshop.zv_date.strftime("%Y-%m-%d")+".pdf"
      File.open(bill_file, 'rb') { |file| a.body = file.read }
    end     
  end
  
  def archive_mail(text, sent_at = Time.now)
    @subject = "Anfrage an das Archiv"
    @body = text
    @recipients = ['archiv@kz-gedenkstaette-dachau.de']
    @from = 'archiv@kz-gedenkstaette-dachau.de'
    @sent_on = sent_at
    @headers = {}
  end
end
