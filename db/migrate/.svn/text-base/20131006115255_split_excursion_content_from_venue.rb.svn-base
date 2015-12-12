class SplitExcursionContentFromVenue < ActiveRecord::Migration
  def self.up
    ThemenTopic.delete_all('content_type = "Exkursion"')
    
    ThemenTopic.create(:content_type => "Exkursion",
      :content => "Gedenkorte in der Umgebung der KZ-Gedenkstätte: Ehemaliger SS-Schießplatz bei Hebertshausen und KZ-Friedhof Leitenberg",
      :venue => "Parkplatz am ehemaligen SS-Schießplatz bei Hebertshausen (Freisinger Straße), eigenes Fahrzeug oder Fahrrad benötigt")
    ThemenTopic.create(:content_type => "Exkursion",
      :content => "Gedenkorte in der Umgebung der KZ-Gedenkstätte: Die 'Plantage'",
      :venue => "Besucherzentrum der KZ-Gedenkstätte Dachau")
    ThemenTopic.create(:content_type => "Exkursion",
      :content => "'Weg des  Erinnerns'",
      :venue => "Bahnhof Dachau")
    ThemenTopic.create(:content_type => "Exkursion",
      :content => "'Die Stadt Dachau und das Lager'",
      :venue => "Vor dem Rathaus in der Dachauer Altstadt")
  end

  def self.down
  end
end
