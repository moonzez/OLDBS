class Archive < ActiveRecord::Base
  validates_presence_of :firstname, :message => ""
  validates_presence_of :lastname, :message => ""
  validates_presence_of :street, :message => ""
  validates_presence_of :city, :message => ""
  validates_presence_of :zip, :message => ""
  validates_presence_of :country, :message => ""
  validates_presence_of :email, :message => ""
  
  def language
    formular == 'de' ? 'Deutsch' : 'Englisch'
  end
end