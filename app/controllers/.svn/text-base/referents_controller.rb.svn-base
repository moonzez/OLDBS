class ReferentsController < ApplicationController
  
  def referents_invoices; end
  
  def get_invoices   
    @month = params[:month]["(2i)"]
    @year = params[:year]["(1i)"] 
    @month_begin = (@year + "-" + @month + "-01").to_date
    files_generated = Referent.create_all_invoices(@month_begin)
    if files_generated
      #Referent.mark_events_as_paid(@month_begin)
      send_file "#{RAILS_ROOT}/public/bill/referent_bill/pdf/#{ Time.now.year }_#{Time.now.month}.tgz"
    end
  end
  
  def index
    @referents = Referent.find_all_except_inaktiv
    @all_letters = @referents? @referents.map {|ref| ref.lastname.first }.uniq.sort : []
    @checkbox_count = @referents.size + 1
    @checkbox_name = 'mail'+@checkbox_count.to_s
    respond_to do |format|
      format.html
      format.xml  { render :xml => @referents }
    end
  end
  
  def inaktivref
    @referents = Referent.find_inactive_referents
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @referents }
    end
  end
  
  def show
    @referent = Referent.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @referent }
    end
  end

  def new
    @referent = Referent.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @referent }
    end
  end

  def edit
    @referent = Referent.find(params[:id])
    @version = @referent.vers
  end
  
  def deaktiv
    @referent = Referent.find(params[:id])
    @referent.update_attribute(:aktiv, 'inaktiv')    
    respond_to do |format|
      format.html { redirect_to( :back, :id => @referent.id ) }
      format.xml  { render :xml => @referent }
    end
  end
  
  def temp_deaktiv
    @referent = Referent.find(params[:id])
    @referent.update_attribute(:aktiv, 'temporary')    
    respond_to do |format|
      format.html { redirect_to( :back, :id => @referent.id ) }
      format.xml  { render :xml => @referent }
    end
  end
  
  def aktiv
    @referent = Referent.find(params[:id])
    @referent.update_attribute(:aktiv, 'aktiv')    
    respond_to do |format|
      format.html { redirect_to( :back, :id => @referent.id ) }
      format.xml  { render :xml => @referent }
    end
  end

  def create
    @referent = Referent.new(params[:referent])
    respond_to do |format|
      if @referent.save
        flash[:notice] = 'Referent wurde erfolgreich angelegt.'
        format.html { redirect_to(referents_url) }
        format.xml  { render :xml => @referent, :status => :created, :location => @referent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @referent.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @referent = Referent.find(params[:id])
    @version = params[:forvers]
    my_vers = @referent.vers.to_s
    respond_to do |format|
      if @version == my_vers
        if @referent.update_attributes(params[:referent])
          flash[:notice] = 'Die Daten wurden erfolgreich ge&auml;ndert.'
          format.html { redirect_to(:action=> 'index') }
          format.xml  { head :ok }
          @referent.update_attribute(:vers, @referent.vers + 1)
        end
      else
        flash[:notice] = 'Der Datensatz wurde gerade von einem anderen Benutzer geändert. Versuchen Sie es nochmal.'
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @referent = Referent.find(params[:id])
    @ref_dbuser = User.find_by_lastname_and_firstname(@referent.lastname, @referent.firstname)
    if @ref_dbuser != nil then @ref_dbuser.destroy end
    @referent.destroy

    respond_to do |format|
      format.html { redirect_to(referents_url) }
      format.xml  { head :ok }
    end
  end
  
  def events
    @referent = Referent.find(params[:id])
    @today = Time.now.strftime("%Y-%m-%d")
    @lastday = 3.months.from_now.strftime("%Y-%m-%d")

    @detours_grouped = @referent.detours.find_all_from_to_thedate(@today, @lastday, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort
    @ts_requests_grouped = @referent.ts_requests.find_all_from_to_thedate(@today, @lastday, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort
    @htseminars_grouped = @referent.htseminars.find_all_from_to_thedate(@today, @lastday, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort                                          
    @workshops_grouped = @referent.workshops.find_all_from_to_thedate(@today, @lastday, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort
    @opentours_grouped = @referent.opentours.find_all_from_to_date(@today, @lastday, 'status' => 'activ').group_by { |event| event.date }.sort
    
    @dates_array = @detours_grouped.keys + @ts_requests_grouped.keys + @htseminars_grouped.keys +
                   @workshops_grouped.keys + @opentours_grouped.keys
    @dates_array.sort!.uniq!
                     
    @all_events = {}
    @dates_array.each do |date|
      @all_events[date] = []
      @all_events[date] += @detours_grouped[date] if @detours_grouped[date]
      @all_events[date] += @ts_requests_grouped[date] if @ts_requests_grouped[date]
      @all_events[date] += @htseminars_grouped[date] if @htseminars_grouped[date]
      @all_events[date] += @workshops_grouped[date] if @workshops_grouped[date]
      @all_events[date] += @opentours_grouped[date] if @opentours_grouped[date]
    end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @referent }
    end
  end
  
  def eventpast
    @referent = Referent.find(params[:id])
    
    @today = Time.now.strftime("%Y-%m-%d")
    @firstday = 6.months.ago.strftime("%Y-%m-%d")
    
    @detours_grouped = @referent.detours.find_all_from_to_thedate(@firstday, @today, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort
    @ts_requests_grouped = @referent.ts_requests.find_all_from_to_thedate(@firstday, @today, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort
    @htseminars_grouped = @referent.htseminars.find_all_from_to_thedate(@firstday, @today, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort                                        
    @workshops_grouped = @referent.workshops.find_all_from_to_thedate(@firstday, @today, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort
    @opentours_grouped = @referent.opentours.find_all_from_to_date(@firstday, @today, 'status' => 'activ').group_by { |event| event.date }.sort
    
    @dates_array = @detours_grouped.keys + @ts_requests_grouped.keys + @htseminars_grouped.keys +
                   @workshops_grouped.keys + @opentours_grouped.keys
    @dates_array.sort!.uniq!
    
    @all_events = {}
    @dates_array.each do |date|
      @all_events[date] = []
      @all_events[date] += @detours_grouped[date] if @detours_grouped[date]
      @all_events[date] += @ts_requests_grouped[date] if @ts_requests_grouped[date]
      @all_events[date] += @htseminars_grouped[date] if @htseminars_grouped[date]
      @all_events[date] += @workshops_grouped[date] if @workshops_grouped[date]
      @all_events[date] += @opentours_grouped[date] if @opentours_grouped[date]
    end

    respond_to do |format|
      format.html # events.html.erb
      format.xml  { render :xml => @referent }
    end
  end
  
  def zahlen_tour
    @referent = Referent.find(params[:id])
    @tourreferent = Tourreferent.find(params[:tourref])
    @tourreferent.update_attribute(:paid, 'ja')    
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id,:startdata =>params[:startdata], :enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent  }
    end
  end
  
  def get_eventref
    event_class = params[:event_class]
 
    case event_class
    when 'Detour'
      eventref = Tourreferent.find(params[:eventref])
    when 'Htseminar'
      eventref = Htsreferent.find(params[:eventref])
    when 'TsRequest'
      eventref = Tsreferent.find(params[:eventref])
    when 'Workshop'
      eventref = Workreferent.find(params[:eventref])
    when 'Opentour'
      eventref = Opentourref.find(params[:eventref])
    end
    eventref
  end
  
  def pay_event
    @referent = Referent.find(params[:id])
    @eventref = get_eventref
   
    @eventref.update_attribute(:paid, 'ja')
    respond_to do |format|
      format.html { redirect_to( :back, :id => @referent.id ) }
      format.xml  { render :xml => @referent }
    end
  end
  
  def no_pay_event
    @referent = Referent.find(params[:id])
    @eventref = get_eventref
    
    @eventref.update_attribute(:paid, 'nein')
    respond_to do |format|
      format.html { redirect_to( :back, :id => @referent.id ) }
      format.xml  { render :xml => @referent }
    end
  end

  def zahlen_ts
    @referent = Referent.find(params[:id])
    @tsreferent = Tsreferent.find(params[:tsref])
    @tsreferent.update_attribute(:paid, 'ja')    
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id,:startdata =>params[:startdata],:enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent  }
    end
  end
  
  def zahlen_hts
    @referent = Referent.find(params[:id])
    @htsreferent = Htsreferent.find(params[:htsref])
    @htsreferent.update_attribute(:paid, 'ja')    
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id,:startdata =>params[:startdata],:enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent  }
    end
  end
    
  def zahlen_work
    @referent = Referent.find(params[:id])
    @workreferent = Workreferent.find(params[:workref])
    @workreferent.update_attribute(:paid, 'ja')    
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id, :startdata =>params[:startdata], :enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent }
    end
  end
  
  def zahlen_otour
    @referent = Referent.find(params[:id])
    @otourref = Opentourref.find(params[:otourref])
    @otourref.update_attribute(:paid, 'ja')   
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id, :startdata =>params[:startdata], :enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent }
    end
  end
  
  def nicht_zahlen_tour
    @referent = Referent.find(params[:id])
    @tourreferent = Tourreferent.find(params[:tourref])
    @tourreferent.update_attribute(:paid, 'nein')    
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id,:startdata =>params[:startdata],:enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent  }
    end
  end
  
  def nicht_zahlen_ts
    @referent = Referent.find(params[:id])
    @tsreferent = Tsreferent.find(params[:tsref])
    @tsreferent.update_attribute(:paid, 'nein')    
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id,:startdata =>params[:startdata],:enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent  }
    end
  end

  def nicht_zahlen_hts
    @referent = Referent.find(params[:id])
    @htsreferent = Htsreferent.find(params[:htsref])
    @htsreferent.update_attribute(:paid, 'nein')    
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id,:startdata =>params[:startdata],:enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent  }
    end
  end
  
  def nicht_zahlen_work
    @referent = Referent.find(params[:id])
    @workreferent = Workreferent.find(params[:workref])
    @workreferent.update_attribute(:paid, 'nein')    
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id, :startdata =>params[:startdata], :enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent }
    end
  end
  
  def nicht_zahlen_otour
    @referent = Referent.find(params[:id])
    @otourref = Opentourref.find(params[:otourref])
    @otourref.update_attribute(:paid, 'nein')  
    respond_to do |format|
      format.html { redirect_to( :controller => 'referents', :action => 'eventstimechoice', :id => @referent.id, :startdata =>params[:startdata], :enddata =>params[:enddata]  ) }
      format.xml  { render :xml => @referent }
    end
  end
  
  def eventstimechoice
    @dates_array = []
    @referent = Referent.find(params[:id])
    @start = params[:startdata]
    @end = params[:enddata]
    if @start != nil && @end != nil   
      @detours_grouped = @referent.detours.find_all_from_to_thedate(@start, @end).group_by { |event| event.thedate }.sort
      @ts_requests_grouped = @referent.ts_requests.find_all_from_to_thedate(@start, @end).group_by { |event| event.thedate }.sort
      @htseminars_grouped = @referent.htseminars.find_all_from_to_thedate(@start, @end).group_by { |event| event.thedate }.sort
      @workshops_grouped = @referent.workshops.find_all_from_to_thedate(@start, @end).group_by { |event| event.thedate }.sort
      @opentours_grouped = @referent.opentours.find_all_from_to_date(@start, @end, 'status' => 'activ').group_by { |event| event.date }.sort
      @dates_array = @detours_grouped.keys + @ts_requests_grouped.keys + @htseminars_grouped.keys +
        @workshops_grouped.keys + @opentours_grouped.keys
      @dates_array.sort!.uniq!
    end
    
    @all_events = {}
    @dates_array.each do |date|
      @all_events[date] = []
      @all_events[date] += @detours_grouped[date] if @detours_grouped[date]
      @all_events[date] += @ts_requests_grouped[date] if @ts_requests_grouped[date]
      @all_events[date] += @htseminars_grouped[date] if @htseminars_grouped[date]
      @all_events[date] += @workshops_grouped[date] if @workshops_grouped[date]
      @all_events[date] += @opentours_grouped[date] if @opentours_grouped[date]
    end
    
    respond_to do |format|
      format.html # eventstimechoice.html.erb
      format.xml  { render :xml => @referent }
    end
  end
  
  def eventstimech
    eventname = params[:eventname]
    @referent = Referent.find(params[:id])
    @start = params[:startdata]
    @end = params[:enddata]
    if @start != nil && @end != nil      
      @detours_grouped = (eventname == 'detour' || eventname == 'all') ?
        @referent.detours.find_all_from_to_thedate(@start, @end, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort : {}
      
      @ts_requests_grouped = (eventname == 'tsrequest' || eventname == 'all') ?
        @referent.ts_requests.find_all_from_to_thedate(@start, @end, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort : {}
      
      @htseminars_grouped = (eventname == 'htseminar' || eventname == 'all') ?
        @referent.htseminars.find_all_from_to_thedate(@start, @end, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort : {}

      @workshops_grouped = (eventname == 'workshop' || eventname == 'all') ?
        @referent.workshops.find_all_from_to_thedate(@start, @end, 'status' => 'bestätigt').group_by { |event| event.thedate }.sort : {}

      @opentours_grouped = (eventname == 'opentour' || eventname == 'all') ?
        @referent.opentours.find_all_from_to_date(@start, @end, 'status' => 'activ').group_by { |event| event.date }.sort : {}
      
      @dates_array = @detours_grouped.keys + @ts_requests_grouped.keys + @htseminars_grouped.keys +
        @workshops_grouped.keys + @opentours_grouped.keys
      @dates_array.sort!.uniq!
    end
    
    @all_events = {}
    @dates_array.each do |date|
      @all_events[date] = []
      @all_events[date] += @detours_grouped[date] if @detours_grouped[date]
      @all_events[date] += @ts_requests_grouped[date] if @ts_requests_grouped[date]
      @all_events[date] += @htseminars_grouped[date] if @htseminars_grouped[date]
      @all_events[date] += @workshops_grouped[date] if @workshops_grouped[date]
      @all_events[date] += @opentours_grouped[date] if @opentours_grouped[date]
    end
    respond_to do |format|
      format.js            
    end
  end    
    
  def topay
    @today = Time.now.strftime("%Y-%m-%d")
    @tourresult = Tourreferent.find(:all, :include => [:referent, :detour], :conditions => "tourreferents.paid = 'nein' AND detours.thedate < '"+@today+"'", :order => "thedate, thefrom")
    @tsresult = Tsreferent.find(:all, :include => [:referent, :ts_request], :conditions => "tsreferents.paid = 'nein' AND ts_requests.thedate < '"+@today+"'", :order => "thedate, thefrom")
    @htsresult = Htsreferent.find(:all, :include => [:referent, :htseminar], :conditions => "htsreferents.paid = 'nein' AND htseminars.thedate < '"+@today+"'", :order => "thedate, thefrom")
    @workresult = Workreferent.find(:all, :include => [:referent, :workshop], :conditions => "workreferents.paid = 'nein' AND workshops.thedate < '"+@today+"'", :order => "thedate, thefrom")
    @openresult = Opentourref.find(:all, :include => [:referent, :opentour], :conditions => "opentourrefs.paid = 'nein' AND opentours.date < '"+@today+"'", :order => "date, time")
    respond_to do |format|
      format.html
      format.xml  
    end
  end
  
  def stornoevents
    @referent = Referent.find(params[:id])
    @detours = @referent.detours.find_all_by_status('storniert')
    @ts_requests = @referent.ts_requests.find_all_by_status('storniert')
    @htseminars = @referent.htseminars.find_all_by_status('storniert')
    @workshops = @referent.workshops.find_all_by_status('storniert')
  end
end