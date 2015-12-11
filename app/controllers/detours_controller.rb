class DetoursController < ApplicationController
  include TextBuilderHelper
  layout :determine_layout
   
  def determine_layout
    case action_name
    when "themennew" then "thementours"
    when "new", "result" then "detours"
    when "neweng", "resulteng" then "toureng"
    when "newfr", "resultfr" then "tourfr"
    when "newit", "resultit" then "tourit"
    else "application"
    end
  end
  
  def set_paid_external
    @tour = Detour.find(params[:id])
    user_name = current_user.lastname + " " + current_user.firstname
    @tour.update_attributes(:paid => 'ja,bar', :set_paid_external => user_name, :set_paid_date => Time.now)
    respond_to do |format|
      format.js
    end
  end
  
  def add_topic
    @themen = ThemenTopic.find_all_by_content_type("Theme")
    @excursions = ThemenTopic.find_all_by_content_type("Exkursion")
    @themen_topic = ThemenTopic.new
  end
  
  def add_new_topic
    @themen_topic = ThemenTopic.new(params[:themen_topic])
    respond_to do |format|
      if @themen_topic.save
        format.html { redirect_to :action => "add_topic" }
        format.xml  { head :ok }
      else
        format.html { redirect_to :back }
      end
    end
  end
  
  def delete_topic
    @themen_topic = ThemenTopic.find(params[:id])
    @themen_topic.destroy
    respond_to do |format|
      format.html { redirect_to :action => "add_topic" }
    end
  end
  
  def search
    @detours = Detour.search_detours(params)
  end
  
  def denialmail
    @tour = Detour.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/denial_tour', :layout => false )
  end
  
  def engdenialmail
    @tour = Detour.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/denial_toureng', :layout => false )
  end
  
  def itdenialmail
    @tour = Detour.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/denial_tourit', :layout => false )
  end
  
  def frdenialmail
    @tour = Detour.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/denial_tourfr', :layout => false )
  end
  
  def stornomail
    @tour = Detour.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/storno_tour', :layout => false )
  end
  
  def stornomaileng
    @tour = Detour.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/stornoeng_tour', :layout => false )
  end
  
  def stornomailit
    @tour = Detour.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/stornoit_tour', :layout => false )
  end

  def stornomailfr
    @tour = Detour.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/stornofr_tour', :layout => false )
  end
  
  def refermail 
    @referent = Referent.find(params[:id])    
    @tour = Detour.find(params[:tourid])
    @mail_text = render_to_string(:template => '/request_mailer/referent_tour', :layout => false )
  end
  
  def zusage
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefull_tour', :layout => false )
  end
  
  def zusageohnebill
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullohnebill_tour', :layout => false )
  end
  
  def zusageeng
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefulleng_tour', :layout => false )
  end
  
  def zusageit
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullit_tour', :layout => false )
  end

  def zusagefr
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullfr_tour', :layout => false )
  end
  
  def zusageengohnebill
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullengohnebill_tour', :layout => false )
  end
  
  def zusageitohnebill
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullitohnebill_tour', :layout => false )
  end
  
  def zusagefrohnebill
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullfrohnebill_tour', :layout => false )
  end
  
  def zusage_exc
    @tour = Detour.find(params[:id])
    @venue = ThemenTopic.find_by_content(@tour.topic).venue
    @mail_text = render_to_string(:template => '/request_mailer/zusagefull_exc', :layout => false )
  end
  
  def zusage_theme
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefull_theme', :layout => false )
  end
  
  def mahnung
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/mahnung_tour', :layout => false )
  end
  
  def mahnungeng
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/mahnungeng_tour', :layout => false )
  end
  
  def mahnungit
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/mahnungit_tour', :layout => false )
  end
  
  def mahnungfr
    @tour = Detour.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/mahnungfr_tour', :layout => false )
  end
  
  def add_referents
    @referents = Referent.find_active_referents
    @detour = Detour.find(params[:id])
    @detour_referents = @detour.referents
    respond_to do |format|
      format.html
      format.xml  { render :xml => @detour }
    end
  end

  def joinref
    @detour = Detour.find(params[:id])
    @referent = Referent.find(params[:refid])
    @detour.referents << @referent    
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde hinzugefügt'
      format.html { redirect_to( :action => 'add_referents', :id => @detour.id ) }
      format.xml  { render :xml => @detour }
    end
  end
  
  def delref
    @detour = Detour.find(params[:id])
    @referent = Referent.find(params[:refid])
    @detour.referents.delete(@referent)
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde entfernt'
      format.html { redirect_to( :action => 'add_referents', :id => @detour.id ) }
      format.xml  { render :xml => @detour }
    end
  end

  def index; end

  def neweng
    @detour = Detour.new    
    respond_to do |format|      
      format.html 
      format.xml  { render :xml => @detour }
    end
  end
  
  def newfr
    @detour = Detour.new    
    respond_to do |format|      
      format.html 
      format.xml  { render :xml => @detour }
    end
  end
 
  def newit
    @detour = Detour.new    
    respond_to do |format|      
      format.html 
      format.xml  { render :xml => @detour }
    end
  end
  
  def themennew
    @themen = ThemenTopic.find_all_by_content_type("Theme")
    @excursions = ThemenTopic.find_all_by_content_type("Exkursion")
    @detour = Detour.new    
    respond_to do |format|      
      format.html 
      format.xml  { render :xml => @detour }
    end
  end
  
  def new    
    @detour = Detour.new    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @detour }
    end
  end
   
  def newintern    
    @detour = Detour.new    
    respond_to do |format|      
      format.html 
      format.xml  { render :xml => @detour }
    end
  end
  
  def themennewint
    @themen = ThemenTopic.find_all_by_content_type("Theme")
    @excursions = ThemenTopic.find_all_by_content_type("Exkursion")
    @detour = Detour.new    
    respond_to do |format|      
      format.html 
      format.xml  { render :xml => @detour }
    end
  end
  
  def edit
    @detour = Detour.find(params[:id], :include => :referents)
    if @detour.themetour
      @themen = ThemenTopic.find_all_by_content_type("Theme").map {|t| t.content }
      @excursions = ThemenTopic.find_all_by_content_type("Exkursion").map {|t| t.content }
      selected_theme_type = @detour.theme_type
      topic = @detour.topic
      if ((selected_theme_type == "Exkursion") && (!@excursions.include?(topic)))
        @excursions << topic
      elsif (!@themen.include?(topic))
        @themen << topic
      end
    end
    @version = @detour.vers
  end
  
  def edit_new_test
    @detour = Detour.find(params[:id], :include => :referents)
    if @detour.themetour
      @themen = ThemenTopic.find_all_by_content_type("Theme").map {|t| t.content }
      @excursions = ThemenTopic.find_all_by_content_type("Exkursion").map {|t| t.content }
      selected_theme_type = @detour.theme_type
      topic = @detour.topic
      if ((selected_theme_type == "Exkursion") && (!@excursions.include?(topic)))
        @excursions << topic
      elsif (!@themen.include?(topic))
        @themen << topic
      end
    end
    @version = e
    @detour.vers
  end

  def create
    @detour = Detour.new(params[:detour])
    if params[:detour][:themetour]
      @themen = ThemenTopic.find_all_by_content_type("Theme")
      @excursions = ThemenTopic.find_all_by_content_type("Exkursion")
      selected_theme = params[:detour][:topic]
      theme = ThemenTopic.find_by_content(selected_theme)
      if theme
        @detour.theme_type = theme.content_type
      end
    end
    if !logged_in?
      if simple_captcha_valid?        
        respond_to do |format|
          if @detour.save
            set_participnumber(@detour)
            proove_date2(@detour)
            proove_date3(@detour)
            
            case @detour.formular
            when 'eng'
              begin              
                RequestMailer.deliver_result_email_eng(@detour)
              rescue Exception => exc
                @detour.update_attribute(:result_sent, false)
              end
              format.html { redirect_to( :controller => 'detours', :action => 'resulteng', :id => @detour.id ) }
              format.xml  { render :xml => @detour, :status => :created, :location => @detour }
            when 'fr'
              begin              
                RequestMailer.deliver_result_email_fr(@detour)
              rescue Exception => exc
                @detour.update_attribute(:result_sent, false)
              end
              format.html { redirect_to( :controller => 'detours', :action => 'resultfr', :id => @detour.id ) }
              format.xml  { render :xml => @detour, :status => :created, :location => @detour }
            when 'it'
              begin              
                RequestMailer.deliver_result_email_it(@detour)
              rescue Exception => exc
                @detour.update_attribute(:result_sent, false)
              end
              format.html { redirect_to( :controller => 'detours', :action => 'resultit', :id => @detour.id ) }
              format.xml  { render :xml => @detour, :status => :created, :location => @detour }
            else
              begin
                RequestMailer.deliver_result_email(@detour)
              rescue Exception => exc
                @detour.update_attribute(:result_sent, false)
              end
              format.html { redirect_to( :controller => 'detours', :action => 'result', :id => @detour.id ) }
              format.xml  { render :xml => @detour, :status => :created, :location => @detour }
            end 
            
          else
            case @detour.formular
            when 'eng'
              format.html { render :action =>"neweng", :layout => 'toureng' }
              format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }
            when 'fr'
              format.html { render :action =>"newfr", :layout => 'tourfr' }
              format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }
            when 'it'
              format.html { render :action =>"newit", :layout => 'tourit' }
              format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }
            else
              if params[:detour][:themetour]
                format.html { render :action =>"themennew", :layout => 'detours' }
                format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }
              else
                format.html { render :action =>"new", :layout => 'detours' }
                format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }
              end
            end            
          end
        end
      else        
        case @detour.formular
        when 'eng'  
          flash[:notice1] = "Wrong code! Please enter the code that you see in the image!"
          flash[:notice2] = "Please enter the code that you see in the image!"
          render :action =>"neweng", :layout => 'toureng'
        when 'fr'  
          flash[:notice1] = "Le code à la fin du formulaire n’a pas été saisi.<br/>
              Sans ce code, les données du formulaire ne seront pas transmises."
          flash[:notice2] = "Veuillez saisir ici le code affiché!"
          render :action =>"newfr", :layout => 'tourfr'
        when 'it'  
          flash[:notice1] = "Digitare il codice alla fine del modulo!<br/>
            Senza il codice i dati riportati nel modulo non vengono inoltrati!"
          flash[:notice2] = "Digitare il codice riportato alla fine del modulo!"
          render :action =>"newit", :layout => 'tourit'          
        else
          flash[:notice1] = "Der Code am Ende des Formulars wurde nicht eingegeben!<br/>
                                  Ohne diesen Code werden die Formulareingaben nicht weitergeleitet!"
          flash[:notice2] = "Hier bitte den angezeigten Code eingeben!"
          if params[:detour][:themetour]
            render :action =>"themennew", :layout => 'detours'
          else
            render :action =>"new", :layout => 'detours'
          end
        end        
      end
    else
      respond_to do |format|
        if @detour.save
          set_participnumber(@detour)
          proove_date2(@detour)
          proove_date3(@detour)
          
          flash[:notice] = 'Die Anmeldung zum Rundgang wurde erfolgreich gespeichert.'
          @detour.update_attribute(:last_change, current_user.lastname)
          format.html { redirect_to( :controller => 'detours', :action => 'opened') }
          format.xml  { render :xml => @detour, :status => :created, :location => @detour }          
        else
          if params[:detour][:themetour]
            format.html { render :action =>"themennewint" }
          else
            format.html { render :action =>"newintern" }
          end
          format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }      
        end
      end
    end
  end

  def update
    @version = params[:forvers]
    @detour = Detour.find(params[:id])
    my_vers = @detour.vers.to_s
    @themen = ThemenTopic.find_all_by_content_type("Theme").map {|t| t.content }
    @excursions = ThemenTopic.find_all_by_content_type("Exkursion").map {|t| t.content }
    if (@detour.themetour and (@detour.topic != params[:detour]['topic']))
      selected_theme_type = ThemenTopic.find_by_content(params[:detour]['topic']).content_type
      params[:detour]['theme_type'] = selected_theme_type
    end
    abgesagt = ((@detour.status != 'abgesagt') and (params[:detour]['status'] == 'abgesagt'))
    storniert = ((@detour.status != 'storniert') and (params[:detour]['status'] == 'storniert'))
    
    respond_to do |format|
      if @version == my_vers
        if @detour.update_attributes(params[:detour])
          if (abgesagt or storniert)
            @detour.update_attributes(:zus_form => 'nein', :zus_voll => 'nein', :zf_date => nil, :zv_date =>nil) 
            @detour.referents.each do |refer| 
              begin
                mail_text = build_denial_txt_ref(refer.firstname, @detour, current_user)
                RequestMailer.deliver_not_detour(@detour, refer, mail_text)
              rescue Exception => exc
                flash[:notice] = "Es ist ein Fehler aufgetreten: #{exc.class}. Email an den Referenten wurde nicht gesendet."
                redirect_to :back
              end
            end
          end
          if ((@detour.status=='offen') or (@detour.status=='abgesagt'))
            @detour.update_attributes(:thedate => nil, :thefrom => nil, :theto => nil)
          end        
          proove_date2(@detour)
          proove_date3(@detour)
          
          if @detour.status=='offen'
            @detour.update_attributes(:zus_form => 'nein', :zus_voll => 'nein', :denial_sent => 'nein', :storno_send => 'nein',
              :zf_date => nil, :zv_date => nil, :denial_date => nil, :storno_date => nil)
          end          
          if @detour.status=='bestätigt'
            @detour.update_attributes(:denial_sent => 'nein', :storno_send => 'nein', :denial_date => nil, :storno_date => nil)
          end
          @detour.update_attributes(:vers => (@detour.vers + 1))
          @detour.update_attributes(:last_change => current_user.lastname) if !(current_user.lastname == "Wolf" and current_user.firstname == "Andrea")
          flash[:notice] = 'Die Daten wurden erfolgreich aktualisiert.'
          format.html { redirect_to(:action => 'edit') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @detour.errors, :status => :unprocessable_entity }
        end
      else
        flash[:notice] = 'Der Datensatz wurde gerade von einem anderen Benutzer geändert. Versuchen Sie es nochmal.'
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @detour = Detour.find(params[:id])    
    @tourreferents = Tourreferent.find_all_by_detour_id(params[:id])    
    @tourreferents.each { |tr| tr.destroy }     
    @detour.destroy
    respond_to do |format|
      format.html { redirect_to( :back) }
      format.xml  { head :ok }
    end    
  end
  
  def result; end
  
  def resulteng; end
  
  def resultit; end

  def approved; end
    
  def opened
    @detoursoffen = Detour.find_opened
  end
    
  def denial
    @detours = Detour.find_denialed
  end
    
  def storno
    @detours = Detour.find_canceled
  end
    
  def future
    @detoursbest = Detour.find_future
  end
    
  def timech
    @detoursbest = Detour.find_all_from_to_thedate(params[:startdata], params[:enddata], 'status' => 'bestätigt')
    respond_to do |format|
      format.js            
    end
  end
    
  ############################     E-Mail   ###############################################    
     
  def referent_tour
    @detour = Detour.find(params[:id])
    @referent = Referent.find_by_id(params[:referent])
    @tourreferent = Tourreferent.find_by_detour_id_and_referent_id(@detour.id, @referent.id)
    file = "public/buchung/pdf/detours/#{@detour.id}_tour.pdf"
    if !File.exist?(file)
      prepare_overview_html(@detour.id, "detours", "detours", "tour")
      mycommand = prepare_overview_command(@detour.id, "detours", "tour")
      Kernel.system mycommand
    end 
    begin
      RequestMailer.deliver_referent_tour(@detour, @referent, params[:betreff], params[:text], params[:cc])
      @tourreferent.update_attributes(:mailsend => 1, :maildate => Time.now.localtime.strftime("%Y-%m-%d"))
      flash[:notice] = 'Die E-Mail an '+ @referent.lastname+ ' wurde gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}."
      redirect_to :back
    end
  end
    
  def denial_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_denial_tour(@detour, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Absage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      @detour.update_attributes(:denial_sent => 'ja', :denial_date => Time.now)
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}."
      redirect_to :back
    end
  end
    
  def engdenial_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_denial_toureng(@detour, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Absage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      @detour.update_attributes(:denial_sent => 'ja', :denial_date => Time.now)
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}."
      redirect_to :back
    end
  end
    
  def itdenial_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_denial_tourit(@detour, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Absage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      @detour.update_attributes(:denial_sent => 'ja', :denial_date => Time.now)
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}."
      redirect_to :back
    end
  end
  
  def frdenial_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_denial_tourfr(@detour, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Absage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      @detour.update_attributes(:denial_sent => 'ja', :denial_date => Time.now)
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}."
      redirect_to :back
    end
  end
  
  def storno_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_storno_tour(@detour, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      @detour.update_attributes(:storno_send => 'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def stornoeng_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_stornoeng_tour(@detour, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      @detour.update_attributes(:storno_send => 'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def stornoit_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_stornoit_tour(@detour, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      @detour.update_attributes(:storno_send => 'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def stornofr_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_stornofr_tour(@detour, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      @detour.update_attributes(:storno_send => 'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
   
  def zusagevoll_email
    @detour = Detour.find(params[:id])
    #have to be here before email will be sent, needet for bill generation
    @detour.update_attribute(:invoice_number, "R#{@detour.id}")
    prepare_bill_html("detours", "R#{ @detour.id }")
    mycommand = prepare_bill_command("R#{ @detour.id }")    
    Kernel.system mycommand               
    begin
      RequestMailer.deliver_zusagefull_tour(@detour, "public/bill/pdf/R#{@detour.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @detour.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => (@detour.current_fee * @detour.groupnumber), :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @detour.update_attribute(:invoice_number, nil)
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @detour.update_attribute(:invoice_number, nil)
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def zusagevollohnebill_email
    @detour = Detour.find(params[:id])
    begin
      RequestMailer.deliver_zusagefullohnebill_tour(@detour, params[:betreff], params[:text], params[:cc])
      @detour.update_attributes(:zus_voll => 'ja', :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def zusagevolleng_email
    @detour = Detour.find(params[:id])
    #have to be here before email will be sent, needet for bill generation
    @detour.update_attribute(:invoice_number, "R#{@detour.id}") 
    prepare_bill_html("detours", "R#{ @detour.id }", "eng")
    mycommand = prepare_bill_command("R#{ @detour.id }")
    Kernel.system mycommand      
    begin
      RequestMailer.deliver_zusagefulleng_tour(@detour, "public/bill/pdf/R#{@detour.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @detour.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => (@detour.current_fee * @detour.groupnumber), :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @detour.update_attribute(:invoice_number, nil)
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @detour.update_attribute(:invoice_number, nil)
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def zusagevollit_email
    @detour = Detour.find(params[:id])
    #have to be here before email will be sent, needet for bill generation
    @detour.update_attribute(:invoice_number, "R#{@detour.id}") 
    prepare_bill_html("detours", "R#{ @detour.id }", "it")
    mycommand = prepare_bill_command("R#{ @detour.id }")
    Kernel.system mycommand      
    begin
      RequestMailer.deliver_zusagefullit_tour(@detour, "public/bill/pdf/R#{@detour.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @detour.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => (@detour.current_fee * @detour.groupnumber), :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @detour.update_attribute(:invoice_number, nil)
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @detour.update_attribute(:invoice_number, nil)
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end

  def zusagevollfr_email
    @detour = Detour.find(params[:id])
    #have to be here before email will be sent, needet for bill generation
    @detour.update_attribute(:invoice_number, "R#{@detour.id}") 
    prepare_bill_html("detours", "R#{ @detour.id }", "fr")
    mycommand = prepare_bill_command("R#{ @detour.id }")
    Kernel.system mycommand      
    begin
      RequestMailer.deliver_zusagefullfr_tour(@detour, "public/bill/pdf/R#{@detour.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @detour.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => (@detour.current_fee * @detour.groupnumber), :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @detour.update_attribute(:invoice_number, nil)
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @detour.update_attribute(:invoice_number, nil)
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end

  def zusagevollengohnebill_email
    @detour = Detour.find(params[:id])      
    begin
      RequestMailer.deliver_zusagefullengohnebill_tour(@detour, params[:betreff], params[:text], params[:cc])
      @detour.update_attributes(:zus_voll => 'ja' , :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def zusagevollitohnebill_email
    @detour = Detour.find(params[:id])      
    begin
      RequestMailer.deliver_zusagefullitohnebill_tour(@detour, params[:betreff], params[:text], params[:cc])
      @detour.update_attributes(:zus_voll => 'ja' , :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      #flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      flash[:notice] = exc
      redirect_to :back
    end
  end

  def zusagevollfrohnebill_email
    @detour = Detour.find(params[:id])      
    begin
      RequestMailer.deliver_zusagefullfrohnebill_tour(@detour, params[:betreff], params[:text], params[:cc])
      @detour.update_attributes(:zus_voll => 'ja' , :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
      
  def mahnung_email
    @detour = Detour.find(params[:id])
    begin
      if File.exist?("#{RAILS_ROOT}/public/bill/pdf/R#{@detour.id}_bill.pdf")
        ff = "public/bill/pdf/R#{@detour.id}_bill.pdf"
      elsif File.exist?("#{RAILS_ROOT}/public/bill/pdf/RE#{@detour.id}_bill.pdf")
        ff = "public/bill/pdf/RE#{@detour.id}_bill.pdf"
      else
        ff = "public/bill/pdf/RIT#{@detour.id}_bill.pdf"
      end
      RequestMailer.deliver_mahnung_tour(@detour, ff, params[:betreff], params[:text], params[:cc])
      @anzahl = @detour.mahnung+1
      @detour.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
    def mahnungeng_email
    @detour = Detour.find(params[:id])
    begin
      if File.exist?("#{RAILS_ROOT}/public/bill/pdf/R#{@detour.id}_bill.pdf")
        ff = "public/bill/pdf/R#{@detour.id}_bill.pdf"
      elsif File.exist?("#{RAILS_ROOT}/public/bill/pdf/RE#{@detour.id}_bill.pdf")
        ff = "public/bill/pdf/RE#{@detour.id}_bill.pdf"
      else
        ff = "public/bill/pdf/RIT#{@detour.id}_bill.pdf"
      end
      RequestMailer.deliver_mahnungeng_tour(@detour, ff, params[:betreff], params[:text], params[:cc])
      @anzahl = @detour.mahnung+1
      @detour.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def mahnungit_email
    @detour = Detour.find(params[:id])
    begin
      if File.exist?("#{RAILS_ROOT}/public/bill/pdf/R#{@detour.id}_bill.pdf")
        ff = "public/bill/pdf/R#{@detour.id}_bill.pdf"
      elsif File.exist?("#{RAILS_ROOT}/public/bill/pdf/RE#{@detour.id}_bill.pdf")
        ff = "public/bill/pdf/RE#{@detour.id}_bill.pdf"
      else
        ff = "public/bill/pdf/RIT#{@detour.id}_bill.pdf"
      end
      RequestMailer.deliver_mahnungit_tour(@detour, ff, params[:betreff], params[:text], params[:cc])
      @anzahl = @detour.mahnung+1
      @detour.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
    def mahnungfr_email
    @detour = Detour.find(params[:id])
    begin
      if File.exist?("#{RAILS_ROOT}/public/bill/pdf/R#{@detour.id}_bill.pdf")
        ff = "public/bill/pdf/R#{@detour.id}_bill.pdf"
      elsif File.exist?("#{RAILS_ROOT}/public/bill/pdf/RE#{@detour.id}_bill.pdf")
        ff = "public/bill/pdf/RE#{@detour.id}_bill.pdf"
      else
        ff = "public/bill/pdf/RIT#{@detour.id}_bill.pdf"
      end
      RequestMailer.deliver_mahnungfr_tour(@detour, ff, params[:betreff], params[:text], params[:cc])
      @anzahl = @detour.mahnung + 1
      @detour.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @detour.gender+' '+@detour.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @detour.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def tour_pdf
    @detour = Detour.find(params[:id])
    send_pdf(@detour.id, "detours", "detours", "tour")
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