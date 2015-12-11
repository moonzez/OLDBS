class AdministratorsController < ApplicationController

  $leerdate  #Globale Variable, kann aus allen views des controllers aufgerufen und geändert werden
  $countfile = 0
  
  def index
    Dir.glob('public/buchung/**/*.*').each { |file| $countfile += 1 }
    Dir.glob('public/bill/html/*.*').each { |file| $countfile += 1 }
  end
  
  def clean        
    mycommand1 = ""
    mycommand2 = ""
    mycommand1 << "rm public/buchung/*/*/*.* -f"
    mycommand2 << "rm public/bill/html/*.* -f"
 
    if(Kernel.system mycommand1)
      if(Kernel.system mycommand2)
        $leerdate = Time.now
        $countfile = 0
        flash[:notice]= 'Tempor&auml;re Ordner wurden geleert.'
        redirect_to :action => 'index'
      end
    else
      flash[:notice] = "Ein Fehler ist aufgetreten. Versuchen Sie es noch mal."
      redirect_to :action => 'index'
    end
  end
end