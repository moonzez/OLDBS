module TextBuilderHelper
  def build_denial_txt_ref(firstname, detour, current_user)
    thedate = detour.thedate.strftime("%d.%m.%Y")
    thefrom = detour.thefrom.strftime("%H:%M")
    current_user = current_user.firstname + " " + current_user.lastname
    str = "";
    ff = "#{RAILS_ROOT}/app/views/request_mailer/denial_tour_ref.erb";
    File.open(ff, 'rb') { |file| str = file.read }
    str = str.gsub(/%FIRSTNAME%/, firstname).sub(/%THEDATE%/, thedate).gsub(/%THEFROM%/, thefrom).gsub(/%CURRENT_USER%/, current_user)
    str
  end
end