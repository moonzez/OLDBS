class DbusersController < ApplicationController
  include ApplicationHelper
  layout :determine_layout, :except => [:print_calend_actual]
  
  before_filter :get_all_best_for_date, :only => [:datum_kalend, :readerkalendheute]
  before_filter :get_all_offen_for_date, :only => [:datum_kalend, :readerkalendheute]
  before_filter :get_all_denied_for_date, :only => [:readerkalendheute]
  before_filter :get_all_best_from_bis_thedate, :only => [:readzeitraum, :kalendaktuell, :print_calend_actual, :zeitraum_kalend]
  before_filter :get_all_offen_from_bis_date, :only => [:readzeitraum, :kalendaktuell, :print_calend_actual, :zeitraum_kalend]
  before_filter :get_all_denied_from_bis_date, :only => [:readzeitraum]
   
  def determine_layout
    return "readers" if action_name=="calendar" and reader? 
    "application"
  end

  def index; end
  
  def readerkalendheute; end
 
  def readzeitraum 
    respond_to do |format|
      format.js
    end
  end
 
  def jahrstat
    @monthes    = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
    @year       = (params[:data]["(1i)"])
    @tours      = Detour.find_for_year(@year)
    @tseminars  = TsRequest.find_for_year(@year)
    @htseminars = Htseminar.find_for_year(@year)
    @workshops  = Workshop.find_for_year(@year)
    @opentours  = Opentour.find_for_year(@year)

    @month_data = Array.new
    @ts_data    = Array.new
    @hts_data   = Array.new
    @ws_data    = Array.new
    @ot_data    = Array.new

    k = groups_summe = persons_summe = tsgroups_summe = tspersons_summe = htsgroups_summe = htspersons_summe = 0
    wsgroups_summe = wspersons_summe = otgroups_summe = otpersons_summe  = 0

    @monthes.each do |month|
      @tours_month = @tours.find_all {|i| i.thedate.strftime("%m") == month}
      @ts_month    = @tseminars.find_all {|i| i.thedate.strftime("%m") == month}
      @hts_month   = @htseminars.find_all {|i| i.thedate.strftime("%m") == month}
      @ws_month    = @workshops.find_all {|i| i.thedate.strftime("%m") == month}
      @ot_month    = @opentours.find_all {|i| i.date.strftime("%m") == month}

      gr = tn = tsgr = tstn =  htsgr = htstn = wsgr = wstn = otgr = ottn = 0

      mon = get_full_germ_month(month)

      @tours_month.each do |tour|
        gr  = gr + tour.groupnumber
        tn  = tn + tour.participnumber           
      end

      groups_summe  = groups_summe + gr
      persons_summe = persons_summe + tn
      h = {'month' => mon, 'groups' => gr, 'persons' => tn, 'id' => k + 1}
      @month_data.push(h)

      @ts_month.each do |ts|
        tsgr  = tsgr + ts.groupnumber
        tstn  = tstn + ts.participnumber
      end

      tsgroups_summe  = tsgroups_summe + tsgr
      tspersons_summe = tspersons_summe + tstn
      tsh = {'month' => mon, 'groups' => tsgr, 'persons' => tstn, 'id' => k + 1}
      @ts_data.push(tsh)

      @hts_month.each do |hts|
        htsgr  = htsgr + hts.groupnumber
        htstn  = htstn + hts.participnumber
      end

      htsgroups_summe  = htsgroups_summe + htsgr
      htspersons_summe = htspersons_summe + htstn
      htsh = {'month' => mon, 'groups' =>htsgr, 'persons' => htstn, 'id' => k + 1 }
      @hts_data.push(htsh)

      @ws_month.each do |ws|
        wsgr  = wsgr + 1
        wstn  = wstn + ws.participnumber
      end

      wsgroups_summe  = wsgroups_summe + wsgr
      wspersons_summe = wspersons_summe + wstn
      wsh = {'month' => mon, 'groups' => wsgr, 'persons' => wstn, 'id' => k + 1}
      @ws_data.push(wsh)

      @ot_month.each do |ot|
        otgr  = otgr + 1
        if (ot.participnumber != nil)
           ottn  = ottn + ot.participnumber
        end
      end

      otgroups_summe  = otgroups_summe + otgr;
      otpersons_summe = otpersons_summe + ottn;
      oth = {'month' => mon, 'groups'=> otgr, 'persons' => ottn, 'id'=> k + 1}
      @ot_data.push(oth)

      k = k + 1
    end

    # Summen
    gesamt   = {'month' => "Gesamt", 'groups' => groups_summe, 'persons' => persons_summe, 'id'=>" "}
    @month_data.push(gesamt)
    tsgesamt = {'month' => "Gesamt", 'groups' => tsgroups_summe, 'persons' => tspersons_summe, 'id'=>" "}
    @ts_data.push(tsgesamt)
    htsgesamt = {'month' => "Gesamt", 'groups' => htsgroups_summe, 'persons'=> htspersons_summe, 'id'=>" "}
    @hts_data.push(htsgesamt)
    wsgesamt = {'month' => "Gesamt", 'groups' => wsgroups_summe, 'persons'=> wspersons_summe, 'id'=>" "}
    @ws_data.push(wsgesamt)
    otgesamt = {'month' => "Gesamt", 'groups' => otgroups_summe,'persons'=> otpersons_summe, 'id'=>" "}
    @ot_data.push(otgesamt)


     # Sprachen tours
    @langs = @tours.collect(&:language)
    languages = Array.new
    @lang_data = Array.new
    @langs.each { |lg| languages.push(lg) unless languages.include?(lg) }
    languages.each do |lang|
      gr_lang = 0
      tn_lang = 0
      @tours_lang = @tours.find_all {|i| i.language == lang}
      @tours_lang.each do |tour|
        gr_lang = gr_lang + tour.groupnumber
        tn_lang = tn_lang + tour.participnumber
      end
      h_lang = {'language' => lang, 'groups' => gr_lang, 'persons'=> tn_lang}
      @lang_data.push(h_lang)
    end

    # Sprachen opentours
    @otlangs    = @opentours.collect(&:language)
    otlanguages = Array.new
    @otlang_data = Array.new
    @otlangs.each { |lg| otlanguages.push(lg) unless otlanguages.include?(lg) }
    otlanguages.each do |lang|
      otgr_lang  = 0
      ottn_lang  = 0
      @opentours_lang = @opentours.find_all {|i| i.language == lang}
      @opentours_lang.each do |tour|
        otgr_lang = otgr_lang + 1
        if (tour.participnumber != nil)
          ottn_lang = ottn_lang + tour.participnumber
        end
      end

      ot_lang = {'language' => lang, 'groups' => otgr_lang, 'persons' => ottn_lang}
      @otlang_data.push(ot_lang)
    end
  end
 
  def kalendaktuell
    @today = Date.current
    @lastday = 3.months.from_now.to_date
    @daten = Array.new
    (@today..@lastday).each { |day| @daten.push(day) }
    set_aliases
    get_datums
  end
  
  def print_calend_actual   
    @today = params[:startdata].to_date
    @lastday = params[:enddata].to_date
    @daten = Array.new
    (@today..@lastday).each { |day| @daten.push(day) } 
    set_aliases
    get_datums
  end
  
  def datum_kalend
    @grb = @detoursbest.collect(&:groupnumber).sum
    @gro = @detoursoffen.collect(&:groupnumber).sum
    @opentactiv = @opentours
    respond_to do |format|
      format.js
    end
  end
  
  def zeitraum_kalend     
    @daten = Array.new
    @firstday = params[:startdata].to_date
    @lastday = params[:enddata].to_date
    (@firstday..@lastday).each { |day| @daten.push(day) }
    set_aliases
    get_datums    
    respond_to do |format|
      format.js
    end
  end
    
  private
  
  def get_all_best_from_bis_thedate
    params[:startdata] = Time.now.strftime("%Y-%m-%d") unless params[:startdata]
    params[:enddata] = 3.months.from_now.strftime("%Y-%m-%d") unless params[:enddata]
    @detoursbest = Detour.find_all_from_to_thedate(params[:startdata], params[:enddata], 'status' => 'bestätigt' )
    @tsbest = TsRequest.find_all_from_to_thedate(params[:startdata], params[:enddata], 'status' => 'bestätigt' )
    @htsbest = Htseminar.find_all_from_to_thedate(params[:startdata], params[:enddata], 'status' => 'bestätigt' ) 
    @workbest = Workshop.find_all_from_to_thedate(params[:startdata], params[:enddata], 'status' => 'bestätigt' )
    @opentours = Opentour.find_all_from_to_date(params[:startdata], params[:enddata], 'status' => 'activ' )
  end
  
  def get_all_best_for_date
    params[:data]= Time.now.strftime("%Y-%m-%d") unless params[:data]
    @detoursbest = Detour.find_all_for_thedate(params[:data], 'bestätigt')
    @workbest = Workshop.find_all_for_thedate(params[:data], 'bestätigt')
    @tsbest = TsRequest.find_all_for_thedate(params[:data], 'bestätigt')
    @htsbest = Htseminar.find_all_for_thedate(params[:data], 'bestätigt')
    @opentours = Opentour.find_all_for_date(params[:data])    
  end
  
  def get_all_offen_from_bis_date
    params[:startdata] = Time.now.strftime("%Y-%m-%d") unless params[:startdata]
    params[:enddata] = 3.months.from_now.strftime("%Y-%m-%d") unless params[:enddata]
    @detoursoffen = Detour.find_all_from_to_date1(params[:startdata], params[:enddata], 'offen')    
    @tsoffen = TsRequest.find_all_from_to_date1(params[:startdata], params[:enddata], 'offen') 
    @htsoffen = Htseminar.find_all_from_to_date1(params[:startdata], params[:enddata], 'offen')    
    @workoffen = Workshop.find_all_from_to_date1(params[:startdata], params[:enddata], 'offen')
  end
  
  def get_all_offen_for_date
    params[:data]= Time.now.strftime("%Y-%m-%d") unless params[:data]
    @detoursoffen = Detour.find_all_for_date1(params[:data], 'offen')
    @workoffen = Workshop.find_all_for_date1(params[:data], 'offen')
    @tsoffen = TsRequest.find_all_for_date1(params[:data], 'offen')
    @htsoffen = Htseminar.find_all_for_date1(params[:data], 'offen')
  end
  
  def get_all_denied_from_bis_date
    @detoursdenied = Detour.find_all_from_to_date1(params[:startdata], params[:enddata], 'abgesagt')
    @tsdenied = TsRequest.find_all_from_to_date1(params[:startdata], params[:enddata], 'abgesagt')
    @htsdenied = Htseminar.find_all_from_to_date1(params[:startdata], params[:enddata], 'abgesagt')     
    @workdenied = Workshop.find_all_from_to_date1(params[:startdata], params[:enddata], 'abgesagt')
  end
  
  def get_all_denied_for_date
    @today = Time.now.strftime("%Y-%m-%d")
    @detoursdenied = Detour.find_all_for_date1(@today, 'abgesagt')
    @workdenied = Workshop.find_all_for_date1(@today, 'abgesagt')
    @tsdenied = TsRequest.find_all_for_date1(@today, 'abgesagt')
    @htsdenied = Htseminar.find_all_for_date1(@today, 'abgesagt')
  end
  
  def set_aliases
    @d_b = @detoursbest; @d_o = @detoursoffen
    @ts_b = @tsbest; @ts_o = @tsoffen
    @hts_b = @htsbest; @hts_o = @htsoffen
    @w_b = @workbest; @w_o = @workoffen
    @o_t = @opentours
  end
  
  def get_datums
    @daten1 = @detoursbest.collect(&:thedate).uniq
    @daten2 = @detoursoffen.collect(&:date1).uniq
    @daten3 = @tsbest.collect(&:thedate).uniq
    @daten4 = @tsoffen.collect(&:date1).uniq
    @daten5 = @htsbest.collect(&:thedate).uniq
    @daten6 = @htsoffen.collect(&:date1).uniq  
    @daten7 = @workbest.collect(&:thedate).uniq
    @daten8 = @workoffen.collect(&:date1).uniq
    @daten9 = @opentours.collect(&:date).uniq
  end
end
      