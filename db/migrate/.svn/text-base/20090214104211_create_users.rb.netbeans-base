class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string :firstname
      t.string :lastname
      t.string :role #admin, dbuser, reader, referee, accounter
      t.string :login
      t.string :crypted_password,          :limit => 40
      t.string :password_confirmation
      t.string :salt,                      :limit => 40
      t.string :remember_token
      t.datetime :remember_token_expires_at
      t.timestamps
     end 
     
    User.create(
      :firstname=> "Sveta",              
      :lastname => "Danti",
      :role => "admin",
      :login => "sveta",      
      :password => "password2",
      :password_confirmation => "password2"
    )
  end

  def self.down
    drop_table "users"
  end
end
