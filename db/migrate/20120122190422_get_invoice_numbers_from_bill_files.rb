class GetInvoiceNumbersFromBillFiles < ActiveRecord::Migration
  def self.up
    Detour.all.each do |tour|
      if File.exists?("#{RAILS_ROOT}/public/bill/pdf/R#{tour.id}_bill.pdf")
        tour.invoice_number = "R#{tour.id}"
      elsif File.exists?("#{RAILS_ROOT}/public/bill/pdf/RE#{tour.id}_bill.pdf")
        tour.invoice_number = "RE#{tour.id}"
      else
        tour.invoice_number = nil
      end
      tour.save
    end
    
    Htseminar.all.each do |hts|
      if File.exists?("#{RAILS_ROOT}/public/bill/pdf/HTS#{hts.id}_bill.pdf")
        hts.invoice_number = "HTS#{hts.id}"
      elsif File.exists?("#{RAILS_ROOT}/public/bill/pdf/HTSE#{hts.id}_bill.pdf")
        hts.invoice_number = "HTSE#{hts.id}"
      else
        hts.invoice_number = nil
      end
      hts.save
    end
    
    TsRequest.all.each do |ts|
      if File.exists?("#{RAILS_ROOT}/public/bill/pdf/TS#{ts.id}_bill.pdf")
        ts.invoice_number = "TS#{ts.id}"
      else
        ts.invoice_number = nil
      end
      ts.save
    end
    
    Workshop.all.each do |work|
      if File.exists?("#{RAILS_ROOT}/public/bill/pdf/W#{work.id}_bill.pdf")
        work.invoice_number = "W#{work.id}"
      else
        work.invoice_number = nil
      end
        work.save
    end
  end

  def self.down
  end
end
