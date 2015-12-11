class ApplicationController < ActionController::Base
  
  include SimpleCaptcha::ControllerHelpers   
  include ParseDate
  include AuthenticatedSystem
    
  helper :all # include all helpers, all the time
  
  require "parsedate.rb"
  require 'german_date_names'
  require 'digest/sha1'
  
  protect_from_forgery # :secret => '89c2c874f47ec82d00a60c0d45d0e49a'

  filter_parameter_logging :password, :authenticity_token, :login
  
  rescue_from ActiveRecord::RecordNotFound, :with => :rescue_action_in_public
   
  private
  
  def set_participnumber(event)  
    participants = event.participnumber
    number = (participants/30).floor
    number +=1 if participants.modulo(30) > 0
    event.update_attribute(:groupnumber, number)
  end
  
  def proove_date2(event)
    if event.date2==nil or event.from2==nil or event.to2==nil
      event.update_attributes(:date2 => nil, :from2 => nil, :to2 => nil)    
    end
  end

  def proove_date3(event)
    if event.date3==nil or event.from3==nil or event.to3==nil
      event.update_attributes(:date3 => nil, :from3 => nil, :to3 => nil)     
    end
  end
  
  # handles 404 when a record is not found.
  def rescue_action_in_public(exception)
    case exception
    when ActiveRecord::RecordNotFound, ActionController::UnknownAction, ActionController::RoutingError
      render :file => "#{RAILS_ROOT}/public/404.html", :layout => 'layouts/application', :status => 404
    else
      super
    end
  end
  
  def send_pdf(event_id, template, foldername, fileend)
    prepare_overview_html(event_id, template, foldername, fileend)
    mycommand = prepare_overview_command(event_id, foldername, fileend)
    if(Kernel.system mycommand)
      send_file "public/buchung/pdf/#{ foldername }/#{ event_id }_#{ fileend }.pdf", :type => "application/pdf"
    else
      render :text => "Erstellen der pdf-Datei fehlgeschlagen."
    end
  end
  
  def prepare_overview_html(event_id, template, foldername, fileend)
    html_string = render_to_string(:template => "/#{ template }/#{ fileend }_pdf", :layout => false)    
    File.open("#{RAILS_ROOT}/public/buchung/html/#{ foldername }/#{ event_id }_#{ fileend }.html", "w") { |file| file.write(html_string) }
  end
  
  def prepare_overview_command(event_id, foldername, fileend)
    mycommand = "" 
    mycommand << " htmldoc --logoimage public/images/logo_dachau.jpg"
    mycommand << " --header ..l"
    mycommand << " --webpage -f"         
    mycommand << " public/buchung/pdf/#{ foldername }/#{ event_id }_#{ fileend }.pdf"
    mycommand << " public/buchung/html/#{ foldername }/#{ event_id }_#{ fileend }.html"
    mycommand
  end
  
  def prepare_bill_html(template, folder, language = nil)
    html_string = render_to_string(:template => "/#{ template }/bill#{'_' + language if language}", :layout => 'bill')
    File.open("#{RAILS_ROOT}/public/bill/html/#{ folder }_bill.html", "w") { |file| file.write(html_string) }
  end
  
  def prepare_bill_command(folder)
    mycommand = ""     
    mycommand << " htmldoc --logoimage public/images/logo_dachau.jpg"
    mycommand << " --header ..l"
    mycommand << " --webpage -f"
    mycommand << " public/bill/pdf/#{ folder}_bill.pdf"
    mycommand << " public/bill/html/#{folder}_bill.html"
    mycommand
  end   
end
