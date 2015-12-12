class SetSendOpetourrefs < ActiveRecord::Migration
  def self.up
    Opentourref.all.each do |opent|
      if (opent.mailsend == 0)
        opent.mailsend = true
        opent.maildate = opent.created_at
        opent.changed_by = 'migration 09032014'
        opent.save
       end
    end
  end

  def self.down
  end
end
