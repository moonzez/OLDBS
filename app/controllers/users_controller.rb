class UsersController < ApplicationController 

  def new
    @user = User.new
  end
  
  def referees
    @referents = Referent.find_active_referents
    @users = User.find_all_by_role("referee")
    @referents.delete_if do |referee| 
      @users.any? { |user| ((user.lastname == referee.lastname) and (user.firstname == referee.firstname)) }
    end
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @referents }
    end
  end
  
  def newref
    @referee = Referent.find(params[:id])
    @user = User.new    
  end
 
  def create_refuser
    @refid = params[:id]
    @user = User.new(params[:user])
    @user.firstname = params[:firstname]
    @user.lastname = params[:lastname]
    @user.role = params[:role]
    
    respond_to do |format|
      if @user.save
        flash[:notice] = 'Der neue Benutzer wurde angelegt!'
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      else
        flash[:notice] = @user.errors.full_messages.join('<br />')
        format.html { redirect_to :action => 'newref', :id => @refid }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        flash[:notice] = 'Der neue Benutzer wurde angelegt!'
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def index
    @admins = User.find_all_by_role('admin', :order=> "lastname, firstname")
    @dbusers = User.find_all_by_role('dbuser', :order=> "lastname, firstname")
    @readers = User.find_all_by_role('reader', :order=> "lastname, firstname")
    @referees = User.find_all_by_role('referee', :order => "lastname, firstname") 
    @accounters = User.find_all_by_role('accounter', :order => "lastname, firstname") 
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Details zu dem User wurden erfolgreich aktualisiert.'
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
