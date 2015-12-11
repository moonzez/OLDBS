class RefereesController < ApplicationController
  
  before_filter :today_two_monthes, :except => [:index, :anmelden, :abmelden]
  
  def index
    @referee = Referent.find_by_name(current_user.lastname, current_user.firstname)  
  end
  
  def opent
    @referee = Referent.find_by_name(current_user.lastname, current_user.firstname)  
  end
  
  def opentours
    @referee = Referent.find_by_lastname_and_firstname(current_user.lastname, current_user.firstname) 
    @languages = Array.new
    @languages.push(@referee.language1)
    @languages.push(@referee.language2) if !@referee.language2.blank?
    @languages.push(@referee.language3) if !@referee.language3.blank?
    @condition = "('"+@languages.join("', '")+"')"
    @opentours = Opentour.find_all_with_referents_and_languages(@today.to_s, @two_monthes.to_s, @condition)
  end
  
  def anmelden
    @referent = Referent.find(params[:refid])  
    @opentour = Opentour.find(params[:id])
    @opentourwish = Opentourwish.new
    @opentour.opentourwishes << @opentourwish
    @referent.opentourwishes << @opentourwish
  
    respond_to do |format|
      flash[:notice] = 'Sie haben sich erfolgreich angemeldet.'
      format.html { redirect_to :action => 'opentours' }
      format.xml  { render :xml => @opentour }
    end
  end
  
  def abmelden
    @referent = Referent.find(params[:refid])  
    @opentour = Opentour.find(params[:id])
    @opentour.referenten.delete(@referent)
  
    respond_to do |format|
      flash[:notice] = 'Sie haben sich erfolgreich angemeldet.'
      format.html { redirect_to :action => 'opentours' }
      format.xml  { render :xml => @opentour }
    end   
  end
  
  def sightot
    @today = Time.now.to_date
    @two_monthes = @today + 60
    @referee = Referent.find_by_name(current_user.lastname, current_user.firstname) 
    @opentoursall = Opentour.find_all_from_to_date_with_referent(@today.to_s,  @two_monthes.to_s)
    @opentours = Array.new
    @opentours = @opentoursall.select { |tour| (tour.referenten.include? @referee) or (tour.referent == @referee) }
  end
  
  def detours
    @referee = Referent.find_by_lastname_and_firstname(current_user.lastname, current_user.firstname) 
    @mydetours = @referee.detours.find_all_from_to_thedate(@today.to_s, @two_monthes.to_s, 'status' => 'bestätigt')
  end
  
  def ts_requests
    @referee = Referent.find_by_lastname_and_firstname(current_user.lastname, current_user.firstname) 
    @myts_requests = @referee.ts_requests.find_all_from_to_thedate(@today.to_s, @two_monthes.to_s, 'status' => 'bestätigt')
  end
  
  def hts_requests
    @referee = Referent.find_by_lastname_and_firstname(current_user.lastname, current_user.firstname) 
    @myhts_requests = @referee.htseminars.find_all_from_to_thedate(@today.to_s, @two_monthes.to_s, 'status' => 'bestätigt')
  end

  def workshops
    @referee = Referent.find_by_lastname_and_firstname(current_user.lastname, current_user.firstname) 
    @mywork = @referee.workshops.find_all_from_to_thedate(@today.to_s, @two_monthes.to_s, 'status' => 'bestätigt')
  end
  
  private
 
  def today_two_monthes
    @today = Time.now.to_date
    @two_monthes = @today + 60
  end
end
