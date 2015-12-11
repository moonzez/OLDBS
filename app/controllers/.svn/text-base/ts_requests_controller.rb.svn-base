class TsRequestsController < ApplicationController

  layout :determine_layout
   
  def determine_layout
    if action_name=="new"  or action_name == "result"
      "ts_requests"
    else
      "application"
    end
  end
  
  def set_paid_external
    @ts = TsRequest.find(params[:id])
    user_name = current_user.lastname + " " + current_user.firstname
    @ts.update_attributes(:paid => 'ja,bar', :set_paid_external => user_name, :set_paid_date => Time.now)
    respond_to do |format|
      format.js
    end
  end
  
  def search
    @ts_requests = TsRequest.search_ts(params)
  end
  
  def denialmail
    @ts = TsRequest.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/denial_ts', :layout => false )
  end
  
  def stornomail
    @ts = TsRequest.find(params[:id])
    @mail_text = render_to_string(:template => '/request_mailer/storno_ts', :layout => false )
  end
  
  def storno
    @ts_requests = TsRequest.find_canceled
  end
  
  def refermail 
    @referent = Referent.find(params[:id])    
    @ts = TsRequest.find(params[:tsid])
    @mail_text = render_to_string(:template => '/request_mailer/referent_ts', :layout => false )
  end
  
  def zusage
    @ts = TsRequest.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefull_ts', :layout => false )
  end

  def zusageohnebill
    @ts = TsRequest.find(params[:id]) 
    @mail_text = render_to_string(:template => '/request_mailer/zusagefullohnebill_ts', :layout => false )
  end
  
  def mahnung
    @ts = TsRequest.find(params[:id])  
    @mail_text = render_to_string(:template => '/request_mailer/mahnung_ts', :layout => false )
  end
  
  def add_referents
    @referents = Referent.find_active_referents
    @ts = TsRequest.find(params[:id])
    @ts_referents = @ts.referents
    respond_to do |format|
      format.html
      format.xml  { render :xml => @ts }
    end
  end

  def joinref
    @ts = TsRequest.find(params[:id])
    @referent = Referent.find(params[:refid])
    @ts.referents << @referent
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde hinzugefügt'
      format.html { redirect_to( :action => 'add_referents', :id => @ts.id ) }
      format.xml  { render :xml => @ts }
    end    
  end
  
  def delref
    @ts = TsRequest.find(params[:id])
    @referent = Referent.find(params[:refid])
    @ts.referents.delete(@referent)
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde entfernt'
      format.html { redirect_to( :action => 'add_referents', :id => @ts.id ) }
      format.xml  { render :xml => @ts }
    end
  end
  
  def index
  end

  def new
    @ts_request = TsRequest.new
    @topics = TsTopic.all.map(&:text)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @ts_request }
    end
  end
  
  def newintern
    @ts_request = TsRequest.new
    @topics = TsTopic.all.map(&:text)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @ts_request }
    end 
  end
  
  def edit
    @ts_request = TsRequest.find(params[:id])
    @topics = TsTopic.all.map(&:text)
    @version = @ts_request.vers
  end
  
  def create
    @topics = TsTopic.all.map(&:text)
    @ts_request = TsRequest.new(params[:ts_request])    
    if !logged_in?
      if simple_captcha_valid?        
        respond_to do |format|
          if @ts_request.save
            set_participnumber(@ts_request)        
            proove_date2(@ts_request)
            proove_date3(@ts_request)
            begin
              RequestMailer.deliver_ts_result(@ts_request)
            rescue Exception => exc
              @ts_request.update_attribute(:result_sent, false) 
            end
            format.html { redirect_to( :controller => 'ts_requests', :action => 'result', :id => @ts_request.id ) }
            format.xml  { render :xml => @ts_request, :status => :created, :location => @ts_request }
          else
            format.html { render :action => "new", :layout => 'ts_requests', :topics => @topics }
            format.xml  { render :xml => @ts_request.errors, :status => :unprocessable_entity }
          end
        end
      else
        flash[:notice1] = "Der Code am Ende des Formulars wurde nicht eingegeben!<br/>
                                  Ohne diesen Code werden die Formulareingaben nicht weitergeleitet!"
        flash[:notice2] = "Hier bitte den angezeigten Code eingeben!"
        render :action =>"new", :layout => 'ts_requests'
      end
    else
      respond_to do |format|
        if @ts_request.save
          set_participnumber(@ts_request)        
          proove_date2(@ts_request)
          proove_date3(@ts_request)
          flash[:notice] = 'Die Anmeldung zum Tagesseminar wurde erfolgreich gespeichert.'
          @ts_request.update_attribute(:last_change, current_user.lastname)  
          format.html { redirect_to( :controller => 'ts_requests', :action => 'opened') }
          format.xml  { render :xml => @ts_request, :status => :created, :location => @ts_request }
        else
          format.html { render :action => "newintern", :layout => 'application' }
          format.xml  { render :xml => @ts_request.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def update
    @version = params[:forvers]
    @ts_request = TsRequest.find(params[:id])
    my_vers = @ts_request.vers.to_s
    abgesagt = ((@ts_request.status != 'abgesagt') and (params[:ts_request]['status'] == 'abgesagt'))
    storniert = ((@ts_request.status != 'storniert') and (params[:ts_request]['status'] == 'storniert'))
    respond_to do |format|
      if @version == my_vers
        if @ts_request.update_attributes(params[:ts_request])
          if (abgesagt or storniert)
            @ts_request.update_attributes(:zus_form => 'nein', :zus_voll => 'nein', :zf_date => nil, :zv_date=> nil)
            @ts_request.referents.each do |refer|
              begin
                RequestMailer.deliver_not_ts(@ts_request, refer)
              rescue Exception => exc
                flash[:notice] = "Fehler #{exc.class}."
                format.html { redirect_to(:action => 'edit') }
              end
            end
          end  
          if ((@ts_request.status == 'offen') || (@ts_request.status == 'abgesagt'))
            @ts_request.update_attributes(:thedate => nil, :thefrom => nil, :theto => nil)               
          end
          proove_date2(@ts_request)
          proove_date3(@ts_request)
          if @ts_request.status=='offen'
            @ts_request.update_attributes(:zus_form => 'nein', :zus_voll => 'nein', :denial_sent => 'nein', :storno_sent => 'nein',
              :zf_date => nil, :zv_date => nil, :denial_date => nil, :storno_date => nil)
          end
          if @ts_request.status=='bestätigt'
            @ts_request.update_attributes(:denial_sent => 'nein', :storno_sent => 'nein', :denial_date => nil, :storno_date => nil)
          end
          @ts_request.update_attributes(:vers => (@ts_request.vers + 1))
          @ts_request.update_attributes(:last_change => current_user.lastname) if !(current_user.lastname == "Wolf" and current_user.firstname == "Andrea")
          flash[:notice] = 'Die Daten wurden erfolgreich gespeichert.'
          format.html { redirect_to(:action => 'edit') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @ts_request.errors, :status => :unprocessable_entity }
        end
      else
        flash[:notice] = 'Der Datensatz wurde gerade von einem anderen Benutzer geändert. Versuchen Sie es nochmal.'
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @ts_request = TsRequest.find(params[:id])    
    @tsreferent = Tsreferent.find_all_by_ts_request_id(params[:id])
    @tsreferent.each { |tsr| tsr.destroy }    
    @ts_request.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  def result; end
  
  def approved; end
    
  def opened
    @tsoffen = TsRequest.find_opened
  end
    
  def denial
    @ts_requests = TsRequest.find_denialed
  end
    
  def storno
    @ts_requests = TsRequest.find_all_by_status("storniert", :order=> "date1" )
  end
    
  def future
    @tsbest = TsRequest.find_future
  end
    
  def timech
    @tsbest = TsRequest.find_all_from_to_thedate(params[:startdata], params[:enddata], 'status' => 'bestätigt')
    respond_to do |format|
      format.js
    end
  end

  def add_topic
    @topics = TsTopic.all
    @ts_topic = TsTopic.new    
  end  
  
  def add_new_topic
    @ts_topic = TsTopic.new(params[:ts_topic])
    respond_to do |format|
      if @ts_topic.save
        format.html { redirect_to :action => "add_topic" }
        format.xml  { head :ok }
      else
        format.html { redirect_to :back }
      end
    end
  end
  
  def delete_topic
    @ts_topic = TsTopic.find(params[:id])
    @ts_topic.destroy
    respond_to do |format|
      format.html { redirect_to :action => "add_topic" }
    end
  end  
   
  ##################      E-Mails    #######################################
    
  def referent_send
    @ts_request = TsRequest.find(params[:tsid])
    @referent = Referent.find_by_id(params[:id])
    @tsreferent = Tsreferent.find_by_ts_request_id_and_referent_id(@ts_request.id, @referent.id)
      
    file = "pulic/buchung/pdf/ts_requests/#{@ts_request.id}_ts.pdf"
    if !File.exist?(file)
      prepare_overview_html(@ts_request.id, "ts_requests", "ts_requests", "ts")
      mycommand = prepare_overview_command(@ts_request.id, "ts_requests", "ts")
      Kernel.system mycommand 
    end
    begin  
      RequestMailer.deliver_referent_ts(@ts_request, @referent, params[:betreff], params[:text], params[:cc])
      @tsreferent.update_attributes(:mailsend => 1, :maildate => Time.now.localtime.strftime("%Y-%m-%d"))
      flash[:notice] = 'Die E-Mail an '+ @referent.lastname+ ' wurde gesendet.'
      redirect_to :action => 'edit', :id => @ts_request.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def denial_email
    @ts_request = TsRequest.find(params[:id])
    begin
      RequestMailer.deliver_denial_ts(@ts_request, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Absage an '+ @ts_request.gender+' '+@ts_request.lastname+' wurde  gesendet.'
      @ts_request.update_attributes(:denial_sent => 'ja', :denial_date => Time.now)
      redirect_to :action => 'edit', :id => @ts_request.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def storno_email
    @ts_request = TsRequest.find(params[:id])
    begin
      RequestMailer.deliver_storno_ts(@ts_request, params[:betreff], params[:text], params[:cc])
      flash[:notice] = 'Die E-Mail mit der Stornierung an '+ @ts_request.gender+' '+@ts_request.lastname+' wurde  gesendet.'
      @ts_request.update_attributes(:storno_sent => 'ja', :storno_date => Time.now)
      redirect_to :action => 'edit', :id => @ts_request.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def zusagevoll_email
    @ts = TsRequest.find(params[:id])
    #have to be here before email will be sent, needet for bill generation
    @ts.update_attribute(:invoice_number, "TS#{@ts.id}")
    prepare_bill_html("ts_requests", "TS#{ @ts.id }")
    mycommand = prepare_bill_command("TS#{ @ts.id }")
    Kernel.system mycommand    
    begin  
      RequestMailer.deliver_zusagefull_ts(@ts, "public/bill/pdf/TS#{@ts.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @ts.update_attributes(:zus_voll => 'ja', :bill_sent => 'ja', :given_price => (@ts.current_fee * @ts.groupnumber), :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @ts.gender+' '+ @ts.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id => @ts.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      @ts.update_attribute(:invoice_number, "TS#{@ts.id}")
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      @ts.update_attribute(:invoice_number, "TS#{@ts.id}")
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
    
  def zusagevollohnebill_email
    @ts = TsRequest.find(params[:id])      
    begin  
      RequestMailer.deliver_zusagefullohnebill_ts(@ts, params[:betreff], params[:text], params[:cc])
      @ts.update_attributes(:zus_voll => 'ja', :given_price => 0.0, :zv_date => Time.now)
      flash[:notice] = 'Die E-Mail mit der Zusage an '+ @ts.gender+' '+ @ts.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id => @ts.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end
  
  def mahnung_email
    @ts = TsRequest.find(params[:id])
    begin
      RequestMailer.deliver_mahnung_tour(@ts, "public/bill/pdf/TS#{@ts.id}_bill.pdf", params[:betreff], params[:text], params[:cc])
      @anzahl = @ts.mahnung+1
      @ts.update_attributes(:mahnung => @anzahl, :mahnungdate => Time.now)
      flash[:notice] = 'Die E-Mail mit der Mahnung und der Rechnung an '+ @ts.gender+' '+@ts.lastname+' wurde  gesendet.'
      redirect_to :action => 'edit', :id =>  @ts.id
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Überprüfen Sie die E-Mail Adressen. Die Trennung durch Komma. Or Fehler : #{exc.class}"
      redirect_to :back
    end
  end   

  def ts_pdf
    @ts_request = TsRequest.find(params[:id])
    send_pdf(@ts_request.id, "ts_requests", "ts_requests", "ts")
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
