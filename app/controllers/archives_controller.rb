#encoding: uft-8
class ArchivesController < ApplicationController
  layout :determine_layout
  
  def determine_layout
    language = params[:language]
    if language
      language == 'en' ? "archiveeng" : "archive" 
    else
      action_name == "neweng" ? "archiveeng" : "archive"
    end
  end
  
  def new
    @archive = Archive.new
  end
  
  def neweng
    @archive = Archive.new
  end
  
  def create
    @archive = Archive.new(params[:archive])
    language = params[:archive][:formular]
    respond_to do |format|
      if !simple_captcha_valid?
        if language == 'de'
          flash[:notice1] = "Der Code am Ende des Formulars wurde nicht eingegeben!"
          flash[:notice2] = "Hier bitte den angezeigten Code eingeben!"
          format.html { render :action => "new" }
        else
          flash[:notice1] = "Wrong code! Please enter the code that you see in the image!"
          flash[:notice2] = "Please enter the code that you see in the image!"
          format.html { render :action => "neweng", :layout => 'archiveeng'}
        end
      elsif @archive.save
        thanks = (language == 'de') ? "Danke für ihre Anfrage" : "Thanks! Your request was successfully submitted."
        format.html { redirect_to(:action => 'show', :content => thanks, :language => language) }
        text = render_to_string(:template => '/request_mailer/archive_request', :layout => false )
        RequestMailer.deliver_archive_mail(text)
      else
        if language == 'de'
          format.html { render :action => "new" }
        else
          format.html { render :action => "neweng", :layout => 'archiveeng'}
        end
      end
    end
  end

  def show
    @content = params[:content]
  end

end
