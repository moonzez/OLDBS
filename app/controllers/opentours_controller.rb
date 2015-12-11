class OpentoursController < ApplicationController
  layout "application"
  
  def index
  end
  
  def new
    @opentour = Opentour.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @opentour }
    end
  end
  
  def create_day
    @opentour = Opentour.new
    if params[:data].empty?
      respond_to do |format|
        flash[:notice] = "Bitte Termin auswählen."
        format.html { redirect_to :action => :new }
        format.xml  { render :xml => @opentour }
      end
    else
      @day = params[:data].to_date
      @time = params[:time].to_s
      @jazyk = params[:language].to_s
      @participnumber = params[:participnumber]
      Opentour.create(:date => @day, :time => @time, :language => @jazyk, :participnumber => @participnumber, :opentype => params[:opentype].to_s)
      respond_to do |format|
        flash[:notice] = "Der Termin für "+@day.strftime("%d.%m.%Y")+" um "+@time+" Uhr wurde angelegt."
        format.html { redirect_to :action =>"index" }
        format.xml  { render :xml => @opentours }
      end   
    end
  end
  
  def create_month
    @opentours = Opentour.new
    @monat = params[:month]["(2i)"]
    @jahr = params[:year]["(1i)"]    
    @date = ("01-"+@monat+"-"+@jahr).to_date
    @monat_zu_zeigen = @date
    @jazyk = params[:language].to_s
    @participnumber = params[:participnumber]

    @times = Array.new
    (1..21).each do |number|
      parameter = ("time"+number.to_s).to_sym
      @times.push(params[parameter]) if params[parameter]
    end
    
    if @times.empty?
      respond_to do |format|
        flash[:notice] = "Bitte Zeit auswählen"
        format.html { redirect_to :action =>"new" }
        format.xml  { render :xml => @opentours }
      end
    else
      @end_date = @date.end_of_month 
      while @date <= @end_date do
        @times.each do |t|
          #TODO activerecord-import gem install to put all the tours at once
          Opentour.create(:date => @date, :time => t, :language => @jazyk, :participnumber => @participnumber, :opentype => params[:opentype].to_s)
        end
        @date = @date.next
      end
      respond_to do |format|
        flash[:notice] = "Die Termine für "+@monat_zu_zeigen.strftime("%B")+ " "+@jahr+" wurden angelegt."
        format.html { redirect_to :action =>"index" }
        format.xml  { render :xml => @opentours }
      end
    end
  end
  
  def sight
    @today = Time.now.to_date
    @two_monthes = @today + 60
    @opentours = Opentour.find_all_with_referent(@today.to_s, @two_monthes.to_s)
    @day_with_tour = Array.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @opentours }
    end
  end

  # DELETE /opentours/1
  # DELETE /opentours/1.xml
  def destroy
    @opentour = Opentour.find(params[:id])
    @opentourrefs = Opentourref.find_all_by_opentour_id(params[:id])
    @opentourwishes = Opentourwish.find_all_by_opentour_id(params[:id])
    @opentourrefs.each { |otr| otr.destroy }
    @opentourwishes.each { |otw| otw.destroy }
    @opentour.destroy
    respond_to do |format|
      format.html { redirect_to( :back) }
      format.xml  { head :ok }
    end    
  end
  
  def add_referents
    @from = params[:from]
    @referents = Referent.find_active_referents
    @opentour = Opentour.find(params[:id])
    @optref = @opentour.referent
    @optwishes = @opentour.referenten
    respond_to do |format|
      format.html # add_referents.html.erb
      format.xml  { render :xml => @opentour }
    end
  end
  
  def delref
    @opentour = Opentour.find(params[:id])
    @from = params[:from]
    @referent = Referent.find(params[:refid])
    if @opentour.referent
      @opentour.opentourref = nil
    end
    respond_to do |format|
      flash[:notice] = @referent.lastname + ' wurde entfernt'
      format.html { redirect_to( :action => 'add_referents', :id => @opentour.id, :from => @from ) }
      format.xml  { render :xml => @opentour }
    end
  end
  
  def joinref
    @from = params[:from]
    @opentour = Opentour.find(params[:id])
    @referent = Referent.find(params[:refid])
    @opentour.referent = @referent
    
    respond_to do |format|
      format.html { redirect_to( :action => 'add_referents', :id => @opentour.id, :from => @from ) }
      format.xml  { render :xml => @opentour }
    end
  end
  
  def deaktiv
    @opentour = Opentour.find(params[:id])
    @opentour.update_attribute(:status, 'deactiv')
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml => @opentour }
    end
  end

  def aktiv
    @opentour = Opentour.find(params[:id])
    @opentour.update_attribute(:status, 'activ')
    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { render :xml => @opentour }
    end
  end
  
  def edit
    @opentour = Opentour.find(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @opentour }
    end
  end
  
  def update
    @opentour = Opentour.find(params[:id])
    @opentour.update_attributes(params[:opentour])
    respond_to do |format|
      flash[:notice] = 'Die Daten wurden erfolgreich ge&auml;ndert.'
      format.html {redirect_to :action => 'sight'}
      format.xml  { render :xml => @opentour }
    end
  end
  
  def selectotour
  end

  def select_monat
    @monat = params[:month]["(2i)"]
    @jahr = params[:year]["(1i)"]    
    @first_day = ("01-"+@monat+"-"+@jahr).to_date
    @last_day = @first_day.end_of_month
    @opentours = Opentour.find_all_with_referent(@first_day.to_s, @last_day.to_s)
    respond_to do |format|
      format.js
    end  
  end
  
  def sendrefmail
    @opentour = Opentour.find(params[:opentour_id])
    @referent = Referent.find(params[:referent_id])   
    @mail_text = render_to_string(:template => '/request_mailer/referent_otour', :layout => false )
  end
  
  def referent_otour
    @referent = Referent.find(params[:id])
    @opentourref = Opentourref.find_by_opentour_id_and_referent_id(params[:opentour_id], params[:id])
    begin
      RequestMailer.deliver_referent_otour(@referent, params[:betreff], params[:text])
      @opentourref.update_attributes(:mailsend => 1, :maildate => Time.now.localtime.strftime("%Y-%m-%d"))
      redirect_to :action => 'sight'
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:notice] = "Fehler Mail-Server: #{e.class}."
      redirect_to :back      
    rescue Exception => exc
      flash[:notice] = "Fehler : #{exc.class}."
      redirect_to :back
    end
  end
 
end

