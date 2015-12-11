# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  def new
  end

  def create
    begin
      self.current_user = User.authenticate(params[:login], params[:password])
      rescue ActiveRecord::StatementInvalid
      flash[:notice] = "Falshes Login und/oder Password"
      render :action => 'new'
    else
      if logged_in?
        if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
        end
        redirect_back_or_default('/administrators/') if current_user.role == "admin"
        redirect_back_or_default('/dbusers/') if (current_user.role == "dbuser") or (current_user.role == "accounter")
        redirect_back_or_default('/referees') if current_user.role == "referee"
        redirect_back_or_default('/dbusers/readerkalendheute/') if current_user.role == "reader"
      else
        flash[:notice] = "Falshes Login und/oder Password"
        render :action => "new"
      end
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Sie haben sich abgemeldet."
    redirect_back_or_default('/login')
  end
end
