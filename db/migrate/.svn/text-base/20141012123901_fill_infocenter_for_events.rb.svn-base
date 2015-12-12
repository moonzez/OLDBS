class FillInfocenterForEvents < ActiveRecord::Migration
  def self.up
    sql1 = 'update detours set infocenter = comments'
    execute sql1
    sql2 = 'update htseminars set infocenter = comments'
    execute sql2
    sql3 = 'update ts_requests set infocenter = comments'
    execute sql3
    sql4 = 'update workshops set infocenter = comments'
    execute sql4

    sql5 = 'update opentours set infocenter = comment'
    execute sql5
  end

  def self.down
  end
end
