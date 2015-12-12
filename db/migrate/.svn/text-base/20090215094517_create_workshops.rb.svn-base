class CreateWorkshops < ActiveRecord::Migration
  def self.up
    create_table :workshops do |t|
      t.string :gender
      t.string :firstname
      t.string :lastname
      t.string :telpriv
      t.string :telprivTime
      t.string :telbus
      t.string :telbusTime
      t.string :fax
      t.string :email      
      t.string :schoolname
      t.string :schooltype
      t.string :zip
      t.string :city
      t.string :country
      t.string :street
      t.date :date1
      t.time :from1
      t.time :to1

      t.integer :participnumber
      t.integer :male
      t.integer :female
      t.string :age
      t.string :schoolgrade
      t.integer :teamleader
      t.string :havebeen # yes, no, some
      t.string :reason
      t.string :municstay
      t.string :food #ja, nein, falls ja dann auch anzahl
      t.integer :foodnumber
      t.string :remarc

      #Verwaltungsdaten      
      t.date :thedate 
      t.string :day 
      t.time :thefrom            
      t.time :theto      
      t.string :status,               :default => "offen"  #offen, abgesagt, bestaetigt, storniert
      t.string :referent,             :default => ""         
      t.string :comments
      t.string :paid,                 :default => "nein"  #ja, nein
      t.string :bill_sent,            :default => "nein"  #ja, nein
      t.string :denial_sent,          :default => "nein"  #ja, nein
      t.string :room
      t.string :last_change           #wer, als letztes die daten geändert hat
      t.string :hl_number
      t.string :zus_form, :default => "nein"
      t.string :zus_voll, :default => "nein"
      t.date  :zf_date
      t.date  :zv_date
      t.date  :denial_date
      t.integer :vers, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :workshops
  end
end
