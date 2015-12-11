class HtseminarsController < ApplicationController
  
  layout :determine_layout

  def determine_layout
    case action_name
    when "new", "result" then "htseminars"
    when "neweng", "resulteng" then "htseminarseng"
    when "newit", "resultit" then "htseminarsit"
    when "newfr", "resultfr" then "htseminarsfr"
    else "application"      
    end
  end
  
  def set_paid_external
    @hts = Htseminar.find(params[:id])
    user_name = current_user.lastname + " " + current_user.firstname
    @hts.update_attributes(:paid => 'ja,bar', :set_paid_external => user_name, :set_paid_date => Time.now )
    respond_to do |format|
      format.js
    end
  end
 
  def search
    @htseminars = Htseminar.search_hts(params)
  end
  
  def denialmail
    @hts = Htseminar.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/denial_hts', :layout => false )
  end
  
  def denialitmail
    @hts = Htseminar.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/denialit_hts', :layout => false )
  end
  
  def stornomail
    @hts = Htseminar.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/storno_hts', :layout => false )
  end

  def stornomaileng
    @hts = Htseminar.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/stornoeng_hts', :layout => false )
  end
  
  def stornomailit
    @hts = Htseminar.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/stornoit_hts', :layout => false )
  end
  
  def refermail 
    @referent = Referent.find(params[:id])    
    @htseminar = Htseminar.find(params[:htsid])
    @mail_text = render_to_string(:template => '/request_mailer/referent_hts', :layout => false )
  end
  
  def zusage
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefull_hts', :layout => false )
  end
 
  def zusageeng
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefulleng_hts', :layout => false )
  end
  
  def zusageit
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullit_hts', :layout => false )
  end

  def zusageohnebill
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullohnebill_hts', :layout => false )
  end
  
  def zusageengohnebill
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullengohnebill_hts', :layout => false )
  end
  
  def zusageitohnebill
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullitohnebill_hts', :layout => false )
  end
  
  def mahnung
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/mahnung_hts', :layout => false )
  end
  
  def mahnungeng
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/mahnungeng_hts', :layout => false )
  end

  def mahnungit
    @hts = Htseminar.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/mahnungit_hts', :layout => false )
  end
  
  def add_referents
    @referents = Referent.find_active_referents
    @hts = Htseminar.find(params[:id])
    @hts_referents = @hts.referents
    respond_to do |format|
      format.html
      format.xml  { render :xml => @hts }
    end
  end  
  
  def joinref
    @hts = Htseminar.find(params[:id])
    @referent = Referent.find(params[:refid])
    @hts.referents << @referent
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde hinzugefügt'
      format.html { redirect_to( :action => 'add_referents', :id => @hts.id ) }
      format.xml  { render :xml => @hts }
    end
  end
  
  def delref
    @hts = Htseminar.find(params[:id])
    @referent = Referent.find(params[:refid])
    @hts.referents.delete(@referent)
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde entfernt'
      format.html { redirect_to( :action => 'add_referents', :id => @hts.id ) }
      format.xml  { render :xml => @hts }
    end
  end
  
  def index; end

  def new
    @htseminar = Htseminar.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @htseminar }
    end
  end
  
  def neweng
    @htseminar = Htseminar.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @htseminar }
    end
  end
  
  def newit
    @htseminar = Htseminar.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @htseminar }
    end
  end
  
  def newfr
    @htseminar = Htseminar.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @htseminar }
    end
  end
  
  def newintern
    @htseminar = Htseminar.new
    respond_to do |format|
      format.html # newintern.html.erb
      format.xml  { render :xml => @htseminar }
    end 
  end
    
  def edit
    @htseminar = Htseminar.find(params[:id])
    @version = @htseminar.vers
  end

  def create
    @htseminar = Htseminar.new(params[:htseminar])
    if !logged_in?
      if simple_captcha_valid?        
        respond_to do |format|
          if @htseminar.save
            set_participnumber(@htseminar)        
            proove_date2(@htseminar)
            proove_date3(@htseminar)
            
            case @htseminar.formular
            when "eng"
              begin
                RequestMailer.deliver_htseng_result(@htseminar)
              rescue Exception => exc
                @htseminar.update_attribute(:result_sent, false)  
              end
              format.html { redirect_to( :controller => 'htseminars', :action => 'resulteng', :id => @htseminar.id ) }
              format.xml  { render :xml => @htseminar, :status => :created, :location => @htseminar }
            when "it"
              begin
                RequestMailer.deliver_htsit_result(@htseminar)
              rescue Exception => exc
                @htseminar.update_attribute(:result_sent, false)  
              end
              format.html { redirect_to( :controller => 'htseminars', :action => 'resultit', :id => @htseminar.id ) }
              format.xml  { render :xml => @htseminar, :status => :created, :location => @htseminar }
            when "fr"
              begin
                RequestMailer.deliver_htsfr_result(@htseminar)
              rescue Exception => exc
                  @htseminar.update_attribute(:result_sent, false)
              end
              format.html { redirect_to( :controller => 'htseminars', :action => 'resultfr', :id => @htseminar.id ) }
              format.xml  { render :xml => @htseminar, :status => :created, :location => @htseminar }
            else
              begin
                RequestMailer.deliver_hts_result(@htseminar)
              rescue Exception => exc
                @htseminar.update_attribute(:result_sent, false) 
              end
              format.html { redirect_to( :controller => 'htseminars', :action => 'result', :id => @htseminar.id ) }
              format.xml  { render :xml => @htseminar, :status => :created, :location => @htseminar }
            end
            
          else
            case @htseminar.formular
            when "eng"
              format.html { render :action => "neweng", :layout => 'htseminarseng' }
              format.xml  { render :xml => @htseminar.errors, :status => :unprocessable_entity }
            when "it"
              format.html { render :action => "newit", :layout => 'htseminarsit' }
              format.xml  { render :xml => @htseminar.errors, :status => :unprocessable_entity }
            when "fr"
              format.html { render :action => "newfr", :layout => 'htseminarsfr' }
              format.xml  { render :xml => @htseminar.errors, :status => :unprocessable_entity }
            else
              format.html { render :action => "new", :layout => 'htseminars' }
              format.xml  { render :xml => @htseminar.errors, :status => :unprocessable_entity }
            end
          end
        end
      else
        case @htseminar.formular
        when 'eng'  
          flash[:notice1] = "Wrong code! Please enter the code that you see in the image!"
          flash[:notice2] = "Please enter the code that you see in the image!"
          render :action =>"neweng", :layout => 'htseminarseng'
        when 'it'  
          flash[:notice1] = "Digitare il codice alla fine del modulo! Senza il codice i dati riportati nel modulo non vengono inoltrati!"
          flash[:notice2] = "Digitare il codice riportato alla fine del modulo!"
          render :action =>"newit", :layout => 'htseminarsit'
        when 'fr'  
          flash[:notice1] = "Wrong code! Please enter the code that you see in the image!"
          flash[:notice2] = "Please enter the code that you see in the image!"
          render :action =>"newfr", :layout => 'htseminarsfr'            
        else
          flash[:notice1] = "Der Code am Ende des Formulars wurde nicht eingegeben!<br/>
                                  Ohne diesen Code werden die Formulareingaben nicht weitergeleitet!"
          flash[:notice2] = "Hier bitte den angezeigten Code eingeben!"
          render :action =>"new", :layout => 'htseminars'
        end
      end
    else
      respond_to do |format|
        if @htseminar.save
          set_participnumber(@htseminar)       
          proove_date2(@htseminar)
          proove_date3(@htseminar)
          
          flash[:notice] = 'Die Anmeldung zum Halbtagesseminar wurde erfolgreich gespeichert.'
          @htseminar.update_attribute(:last_change, current_user.lastname)  
          format.html { redirect_to( :controller => 'htseminars', :action => 'opened') }
          format.xml  { render :xml => @htseminar, :status => :created, :location => @htseminar }
        else
          format.html { render :controller => 'htseminars', :action => "newintern", :layout => 'application' }
          format.xml  { render :xml => @htseminar.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def update
    @version = params[:forvers]
    @htseminar = Htseminar.find(params[:id])
    my_vers = @htseminar.vers.to_s
    abgesagt = ((@htseminar.status != 'abgesagt') and (params[:htseminar]['status'] == 'abgesagt'))
    storniert = ((@htseminar.status != 'storniert') and (params[:htseminar]['status'] == 'storniert'))
    respond_to do |format|
      if @version == my_vers
        if @htseminar.update_attributes(params[:htseminar])
          if (abgesagt or storniert)
            @htseminar.update_attributes(:zus_form => 'nein', :zus_voll => 'nein', :zf_date => nil, :zv_date=> nil)
            @htseminar.referents.each do |refer|
              begin
                @referent = refer
                mail_text = render_to_string(:template => '/request_mailer/storno_ref_hts', :layout => false )
                RequestMailer.deliver_not_hts(@htseminar, refer, mail_text)
              rescue Exception => exc
                flash[:notice] = "Es tut uns leid. Es ist ein Fehler aufgetreten: #{exc.class} . Versuchen Sie es später noch einmal."
                format.html { render :action => "edit"}
              end
            end
          end
          if ((@htseminar.status == 'offen') || (@htseminar.status == 'abgesagt'))
            @htseminar.update_attributes(:thedate => nil, :thefrom => nil, :theto => nil)               
          end
          proove_date2(@htseminar)
          proove_date3(@htseminar)
          if @htseminar.status=='offen'
            @htseminar.update_attributes(:zus_form => 'nein', :zus_voll => 'nein', :denial_sent => 'nein', :storno_send => 'nein',
              :zf_date => nil, :zv_date => nil, :denial_date => nil, :storno_date => nil)
          end
          if @htseminar.status=='bestätigt'
            @htseminar.update_attributes(:denial_sent => 'nein', :storno_send => 'nein', :denial_date => nil, :storno_date => nil)
          end

          @htseminar.update_attributes(:vers => (@htseminar.vers + 1))
          @htseminar.update_attributes(:last_change => current_user.lastname) if !(current_user.lastname == "Wolf" and current_user.firstname == "Andrea")
          flash[:notice] = 'Die Daten wurden erfolgreich gespeichert.'
          format.html { redirect_to(:action => 'edit') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @htseminar.errors, :status => :unprocessable_entity }
        end
      else
        flash[:notice] = 'Der Datensatz wurde gerade von einem anderen Benutzer geändert. Versuchen Sie es nochmal.'
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @htseminar = Htseminar.find(params[:id])    
    @htsreferent = Htsreferent.find_all_by_htseminar_id(params[:id])
    @htsreferent.each {|htsr| htsr.destroy }
    @htseminar.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  def timech
    @htsbest = Htseminar.find_all_from_to_thedate(params[:startdata], params[:enddata], 'status' => 'bestätigt') 
    respond_to do |format|
      format.js
    end
  end
    
  def approved; end

  def denial
    @htseminars = Htseminar.find_denialed
  end
  
  def storno
    @htseminars = Htseminar.find_canceled
  end
  
  def future
    @htsbest = Htseminar.find_future
  end
    
  def opened
    @htsoffen = Htseminar.find_opened
  end

  ##################      E-Mails    #######################################
   
  def referent_send
    @htseminar = Htseminar.find(params[:htsid])
    @referent = Referent.find_by_id(params[:id])
    @htsreferent = Htsreferent.find_by_htseminar_id_and_referent_id(@htseminar.id, @referent.id)
    file = "public/buchung/pdf/hts/#{@htseminar.id}_hts.pdf"
    if !File.exist?(file)
      prepare_overview_html(@htseminar.id, "htseminars", "hts", "hts")
      mycommand = prepare_overview_command(@htseminar.id, "hts", "hts")
      Kernel.system mycommand
    end
    begin
      RequestMailer.deliver_referent_hts(@htseminar, @referent, params[:betreff], params[:text], params[:cc])
      @htsreferent.update_attributes(:mailsend => 1, :maildate => Time.now.localtime.strftime("%Y-%m-%d"))
      flash[:notice] = 'Die E-Mail an '+ @referent.lastname+ ' wurde gesendet.'
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def denial_email
    @htseminar = Htseminar.find(params[:id])
    begin
      RequestMailer.deliver_denial_hts(@htseminar, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Absage an '+ @htseminar.gender+' '+@htseminar.lastname+' wurde  gesendet.'
      @htseminar.update_attributes(:denial_sent => 'ja', :denial_date => Time.now)
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def denialit_email
    @htseminar = Htseminar.find(params[:id])
    begin
      RequestMailer.deliver_denialit_hts(@htseminar, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Absage an '+ @htseminar.gender+' '+@htseminar.lastname+' wurde  gesendet.'
      @htseminar.update_attributes(:denial_sent => 'ja', :denial_date => Time.now)
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def storno_email
    @htseminar = Htseminar.find(params[:id])
    begin
      RequestMailer.deliver_storno_hts(@htseminar, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @htseminar.gender+' '+@htseminar.lastname+' wurde  gesendet.'
      @htseminar.update_attributes(:storno_send =>'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def stornoeng_email
    @htseminar = Htseminar.find(params[:id])
    begin
      RequestMailer.deliver_stornoeng_hts(@htseminar, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @htseminar.gender+' '+@htseminar.lastname+' wurde  gesendet.'
      @htseminar.update_attributes(:storno_send =>'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def stornoit_email
    @htseminar = Htseminar.find(params[:id])
    begin
      RequestMailer.deliver_stornoit_hts(@htseminar, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @htseminar.gender+' '+@htseminar.lastname+' wurde  gesendet.'
      @htseminar.update_attributes(:storno_send =>'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
   
  def zusagevoll_email
    @htseminar = Htseminar.find(params[:id])
    #have to be here before email will bes sent, needet for bill generation
    @htseminar.update_attribute(:invoice_number, "HTS#{@htseminar.id}")
    prepare_bill_html("htseminars", "HTS#{ @htseminar.id }")
    mycommand = prepare_bill_command("HTS#{ @htseminar.id }")
    Kernel.system mycommand
    begin  
      RequestMailer.deliver_zusagefull_hts(@htseminar, "public/bill/pdf/HTS#{@htseminar.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @htseminar.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => (@htseminar.current_fee * @htseminar.groupnumber), :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @htseminar.gender+' '+ @htseminar.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @htseminar.update_attribute(:invoice_number, nil)
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @htseminar.update_attribute(:invoice_number, nil)
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def zusagevolleng_email
    @htseminar = Htseminar.find(params[:id])
    #have to be here before email will bes sent, needet for bill generation
    @htseminar.update_attribute(:invoice_number, "HTS#{@htseminar.id}")
    prepare_bill_html("htseminars", "HTS#{ @htseminar.id }", "eng")
    mycommand = prepare_bill_command("HTS#{ @htseminar.id }")
    Kernel.system mycommand
    begin  
      RequestMailer.deliver_zusagefulleng_hts(@htseminar, "public/bill/pdf/HTS#{@htseminar.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @htseminar.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => (@htseminar.current_fee * @htseminar.groupnumber), :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @htseminar.gender+' '+ @htseminar.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @htseminar.update_attribute(:invoice_number, nil)
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @htseminar.update_attribute(:invoice_number, nil)
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
    def zusagevollit_email
    @htseminar = Htseminar.find(params[:id])
    #have to be here before email will bes sent, needet for bill generation
    @htseminar.update_attribute(:invoice_number, "HTS#{@htseminar.id}")
    prepare_bill_html("htseminars", "HTS#{ @htseminar.id }", "it")
    mycommand = prepare_bill_command("HTS#{ @htseminar.id }")
    Kernel.system mycommand
    begin  
      RequestMailer.deliver_zusagefullit_hts(@htseminar, "public/bill/pdf/HTS#{@htseminar.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @htseminar.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => (@htseminar.current_fee * @htseminar.groupnumber), :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @htseminar.gender+' '+ @htseminar.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @htseminar.update_attribute(:invoice_number, nil)
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @htseminar.update_attribute(:invoice_number, nil)
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
 
  def zusagevollengohnebill_email
    @htseminar = Htseminar.find(params[:id])
    begin  
      RequestMailer.deliver_zusagefullengohnebill_hts(@htseminar, params[:betreff], params[:text], params[:cc])
      @htseminar.update_attributes(:zus_voll => 'ja',  :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @htseminar.gender+' '+ @htseminar.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def zusagevollitohnebill_email
    @htseminar = Htseminar.find(params[:id])
    begin  
      RequestMailer.deliver_zusagefullengohnebill_hts(@htseminar, params[:betreff], params[:text], params[:cc])
      @htseminar.update_attributes(:zus_voll => 'ja',  :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @htseminar.gender+' '+ @htseminar.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id => @htseminar.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def zusagevollohnebill_email
    @hts = Htseminar.find(params[:id])
    begin
      RequestMailer.deliver_zusagefullohnebill_hts(@hts, params[:betreff], params[:text], params[:cc])
      @hts.update_attributes(:zus_voll => 'ja',  :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @hts.gender+' '+ @hts.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id => @hts.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def mahnung_email
    @hts = Htseminar.find(params[:id])
    begin
      if File.exist?("#{RAILS_ROOT}/public/bill/pdf/HTS#{@hts.id}_bill.pdf")
        ff = "public/bill/pdf/HTS#{@hts.id}_bill.pdf"
      elsif File.exist?("#{RAILS_ROOT}/public/bill/pdf/HTSE#{@hts.id}_bill.pdf")
        ff = "public/bill/pdf/HTSE#{@hts.id}_bill.pdf"
      else
        ff ="public/bill/pdf/HTSIT#{@hts.id}_bill.pdf"
      end
      RequestMailer.deliver_mahnung_hts(@hts, ff, params[:betreff], params[:text], params[:cc])
      @anzahl = @hts.mahnung+1
      @hts.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @hts.gender+' '+@hts.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @hts.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def mahnungeng_email
    @hts = Htseminar.find(params[:id])
    begin
      if File.exist?("#{RAILS_ROOT}/public/bill/pdf/HTS#{@hts.id}_bill.pdf")
        ff = "public/bill/pdf/HTS#{@hts.id}_bill.pdf"
      elsif File.exist?("#{RAILS_ROOT}/public/bill/pdf/HTSE#{@hts.id}_bill.pdf")
        ff = "public/bill/pdf/HTSE#{@hts.id}_bill.pdf"
      else
        ff ="public/bill/pdf/HTSIT#{@hts.id}_bill.pdf"
      end
      RequestMailer.deliver_mahnungeng_hts(@hts, ff, params[:betreff], params[:text], params[:cc])
      @anzahl = @hts.mahnung+1
      @hts.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @hts.gender+' '+@hts.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @hts.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def mahnungit_email
    @hts = Htseminar.find(params[:id])
    begin
      if File.exist?("#{RAILS_ROOT}/public/bill/pdf/HTS#{@hts.id}_bill.pdf")
        ff = "public/bill/pdf/HTS#{@hts.id}_bill.pdf"
      elsif File.exist?("#{RAILS_ROOT}/public/bill/pdf/HTSE#{@hts.id}_bill.pdf")
        ff = "public/bill/pdf/HTSE#{@hts.id}_bill.pdf"
      else
        ff ="public/bill/pdf/HTSIT#{@hts.id}_bill.pdf"
      end
      RequestMailer.deliver_mahnungit_hts(@hts, ff, params[:betreff], params[:text], params[:cc])
      @anzahl = @hts.mahnung+1
      @hts.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @hts.gender+' '+@hts.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @hts.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def hts_pdf
    @htseminar = Htseminar.find(params[:id])
    send_pdf(@htseminar.id, "htseminars", "hts", "hts")
  end
 
  def show_bill
    filename = params[:file]
    if File.exist?("#{RAILS_ROOT}/public/bill/pdf/#{filename }")
      send_file "#{RAILS_ROOT}/public/bill/pdf/#{filename }", :type => "application/pdf"
    else
      render :text => "Rechnung ist nicht vorhanden."
    end
  end
end