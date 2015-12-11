class WorkshopsController < ApplicationController

  layout :determine_layout
  
  def determine_layout
    if action_name=="new" or action_name == "result"
      "workshops"
    else
      "application"
    end
  end
 
  def set_paid_external
    @work = Workshop.find(params[:id])
    user_name = current_user.lastname + " " + current_user.firstname
    @work.update_attributes(:paid => 'ja,bar', :set_paid_external => user_name, :set_paid_date => Time.now)
    respond_to do |format|
      format.js
    end
  end
  
  def search
    @workshops = Workshop.search_work(params)
  end
  
  def denialmail
    @workshop = Workshop.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/denial_workshop', :layout => false )
  end
  
  def stornomail
    @workshop = Workshop.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/storno_workshop', :layout => false )
  end
  
  def zusage
    @workshop = Workshop.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefull_workshop', :layout => false )
  end

  def zusageohnebill
    @workshop = Workshop.find(params[:id])  
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullohnebill_workshop', :layout => false )
  end
  
  def mahnung
    @workshop = Workshop.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/mahnung_workshop', :layout => false )
  end
  
  def add_referents
    @referents = Referent.find_active_referents
    @workshop = Workshop.find(params[:id])
    @work_referents = @workshop.referents
    respond_to do |format|
      format.html
      format.xml  { render :xml => @workshop }
    end
  end
  
  def joinref
    @workshop = Workshop.find(params[:id])
    @referent = Referent.find(params[:refid])
    @workshop.referents << @referent   
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde hinzugefügt'
      format.html { redirect_to( :action => 'add_referents', :id => @workshop.id ) }
      format.xml  { render :xml => @workshop }
    end
  end
  
  def delref
    @workshop = Workshop.find(params[:id])
    @referent = Referent.find(params[:refid])
    @workshop.referents.delete(@referent)
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde entfernt'
      format.html { redirect_to( :action => 'add_referents', :id => @workshop.id ) }
      format.xml  { render :xml => @workshop }
    end
  end
  
  def index
  end

  def new
    @workshop = Workshop.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @workshop }
    end
  end
  
  def newintern
    @workshop = Workshop.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workshop }
    end
  end
  
  def create
    @workshop = Workshop.new(params[:workshop])
    if !logged_in?
      if simple_captcha_valid?        
        respond_to do |format|
          if @workshop.save
            proove_date2(@workshop)
            begin
              RequestMailer.deliver_workshop_result(@workshop)
            rescue Exception => exc
              @workshop.update_attribute(:result_sent, false) 
            end
            format.html { redirect_to(:controller => 'workshops', :action => 'result', :id => @workshop.id) }
            format.xml  { render :xml => @workshop, :status => :created, :location => @workshop }
          else
            format.html { render :action => "new", :layout => 'workshops' }
            format.xml  { render :xml => @workshop.errors, :status => :unprocessable_entity }
          end
        end
      else
        flash[:notice1] = "Der Code am Ende des Formulars wurde nicht eingegeben!<br/>
                                  Ohne diesen Code werden die Formulareingaben nicht weitergeleitet!"
        flash[:notice2] = "Hier bitte den angezeigten Code eingeben!"
        render :action =>"new", :layout => 'workshops'
      end
    else
      respond_to do |format|
        if @workshop.save
          proove_date2(@workshop)
          flash[:notice] = 'Die Anmeldung zum Workshop wurde gespeichert!'
          @workshop.update_attribute(:last_change, current_user.lastname) 
          format.html { redirect_to(:controller => 'workshops', :action => 'opened')}  
        else
          format.html { render :action => "newintern", :layout => 'application' }
          format.xml  { render :xml => @workshop.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  def edit
    @workshop = Workshop.find(params[:id])
    @version = @workshop.vers
  end

  def update
    @version = params[:forvers]
    @workshop = Workshop.find(params[:id])
    my_vers = @workshop.vers.to_s
    abgesagt = ((@workshop.status != 'abgesagt') and (params[:workshop]['status'] == 'abgesagt'))
    storniert = ((@workshop.status != 'storniert') and (params[:workshop]['status'] == 'storniert'))
    respond_to do |format|
      if @version == my_vers
        if @workshop.update_attributes(params[:workshop])
          if (abgesagt or storniert)
            @workshop.update_attributes(:zus_form => 'nein', :zus_voll => 'nein', :zf_date => nil, :zv_date=> nil)
            @workshop.referents.each do |refer|
              begin
                RequestMailer.deliver_not_work(@workshop, refer)
              rescue Exception => exc
                flash[:notice] = "Fehler #{exc.class}."
                format.html { redirect_to :action => 'edit', :layout => 'workshops' }
              end
            end
          end
          if ((@workshop.status=='offen') || (@workshop.status=='abgesagt'))
            @workshop.update_attributes(:thedate => nil, :thefrom => nil, :theto => nil)              
          end
          if @workshop.status=='offen'
            @workshop.update_attributes(:zus_form => 'nein', :zus_voll => 'nein', :denial_sent => 'nein', :storno_sent => 'nein',
              :zf_date => nil, :zv_date => nil, :denial_date => nil, :storno_date => nil)
          end
          if @workshop.status=='bestätigt'
            @workshop.update_attributes(:denial_sent => 'nein', :storno_sent => 'nein', :denial_date => nil, :storno_date => nil)
          end

          @workshop.update_attributes(:vers =>(@workshop.vers + 1))
          @workshop.update_attributes(:last_change => current_user.lastname) if !(current_user.lastname == "Wolf" and current_user.firstname == "Andrea")
          flash[:notice] = 'Die Daten wurden erfolgreich gespeichert.'
          format.html { redirect_to(:action => 'edit') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @workshop.errors, :status => :unprocessable_entity }
        end
      else
        flash[:notice] = 'Der Datensatz wurde gerade von einem anderen Benutzer geändert. Versuchen Sie es nochmal.'
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @workshop = Workshop.find(params[:id])    
    @workreferents = Workreferent.find_all_by_workshop_id(params[:id])
    @workreferents.each { |wr| wr.destroy }
    @workshop.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  def result; end
  
  def approved; end 
   
  def opened
    @workoffen = Workshop.find_opened
  end
    
  def denial
    @workshops = Workshop.find_denialed
  end
   
  def storno
    @workshops = Workshop.find_canceled
  end
 
  def future
    @workbest = Workshop.find_future
  end
    
  def timech
    @workbest = Workshop.find_all_from_to_thedate(params[:startdata], params[:enddata], 'status' => 'bestätigt')
    respond_to do |format|
      format.js
    end
  end

  def refermail 
    @referent = Referent.find(params[:id])    
    @workshop = Workshop.find(params[:workid])
    @mail_text = render_to_string(:template => '/request_mailer/referent_work', :layout => false )
  end
  
  ############################     E-Mail   ###############################################  
    
  def referent_work
    @workshop = Workshop.find(params[:id])
    @referent = Referent.find_by_id(params[:referent])
    @workreferent = Workreferent.find_by_workshop_id_and_referent_id(@workshop.id, @referent)
    file = "public/buchung/pdf/workshops/#{@workshop.id}_work.pdf"
    if !File.exist?(file)
      prepare_overview_html(@workshop.id, "workshops", "workshops", "work")
      mycommand = prepare_overview_command(@workshop.id, "workshops", "work")
      Kernel.system mycommand
    end
    begin
      RequestMailer.deliver_referent_work(@workshop, @referent, params[:betreff], params[:text], params[:cc])
      @workreferent.update_attributes(:mailsend => 1, :maildate => Time.now.localtime.strftime("%Y-%m-%d"))
      flash[:notice] = 'Die E-Mail an '+ @referent.lastname+ ' wurde gesendet.'
      redirect_to :action => 'edit', :id =>  @workshop.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def denial_email
    @workshop = Workshop.find(params[:id])
    begin
      RequestMailer.deliver_denial_workshop(@workshop, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Absage an '+ @workshop.gender+' '+@workshop.lastname+' wurde  gesendet.'
      @workshop.update_attributes(:denial_sent => 'ja', :denial_date => Time.now)
      redirect_to :action => 'edit', :id =>  @workshop.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def storno_email
    @workshop = Workshop.find(params[:id])
    begin
      RequestMailer.deliver_storno_workshop(@workshop, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @workshop.gender+' '+@workshop.lastname+' wurde  gesendet.'
      @workshop.update_attributes(:storno_sent =>'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id =>  @workshop.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def zusagevoll_email
    @workshop = Workshop.find(params[:id])   
    #have to be here before email will be sent, needet for bill generation
    @workshop.update_attribute(:invoice_number, "W#{@workshop.id}")    
    prepare_bill_html("workshops", "W#{ @workshop.id }")
    mycommand = prepare_bill_command("W#{ @workshop.id }")
    Kernel.system mycommand        
    begin
      RequestMailer.deliver_zusagefull_workshop(@workshop, "public/bill/pdf/W#{@workshop.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @workshop.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => Workshop::CURRENT_PRICE, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @workshop.gender+' '+@workshop.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @workshop.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @workshop.update_attribute(:invoice_number, "W#{@workshop.id}")    
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @workshop.update_attribute(:invoice_number, "W#{@workshop.id}")    
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
     
  def zusagevollohnebill_email
    @workshop = Workshop.find(params[:id])    
    @work = @workshop
    begin
      RequestMailer.deliver_zusagefullohnebill_workshop(@workshop, params[:betreff], params[:text], params[:cc])
      @workshop.update_attributes(:zus_voll => 'ja', :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @workshop.gender+' '+@workshop.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @workshop.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def mahnung_email
    @workshop = Workshop.find(params[:id])
    begin
      RequestMailer.deliver_mahnung_workshop(@workshop, "public/bill/pdf/W#{@workshop.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @anzahl = @workshop.mahnung+1
      @workshop.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @workshop.gender+' '+@workshop.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @workshop.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def workshop_pdf
    @workshop = Workshop.find(params[:id])
    send_pdf(@workshop.id, "workshops", "workshops", "work")
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
