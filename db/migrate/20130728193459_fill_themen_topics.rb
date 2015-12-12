class FillThemenTopics < ActiveRecord::Migration
  def self.up
    @themen = [
      "Jüdische Häftlinge im Konzentrationslager Dachau",
      "Politische Häftlinge im Konzentrationslager Dachau",
      "Frauen im Konzentrationslager Dachau",
      "Sinti und Roma im Konzentrationslager Dachau",
      "'Nie im Leben hatte es so viel Anlass zum Schreiben gegeben' - Biografisch-literarischer Rundgang durch die KZ-Gedenkstätte Dachau",
      "Die Befreiung des Konzentrationslagers Dachau",
      "Was bleibt? – Die Geschichte der KZ-Gedenkstätte Dachau",
      "Kinder und Jugendliche im Konzentrationslager Dachau"
    ]
    @exkursions  = [
      "Gedenkorte in der Umgebung der KZ-Gedenkstätte: Ehemaliger SS-Schießplatz bei Hebertshausen und KZ-Friedhof Leitenberg. (Treffpunkt: Parkplatz am ehemaligen SS-Schießplatz bei Hebertshausen (Freisinger Straße), eigenes Fahrzeug oder Fahrrad benötigt)",
      "Gedenkorte in der Umgebung der KZ-Gedenkstätte: Die 'Plantage'. (Treffpunkt: Besucherzentrum der KZ-Gedenkstätte Dachau)",
      "'Weg des  Erinnerns'. (Treffpunkt: Bahnhof Dachau)",
      "'Die Stadt Dachau und das Lager'. (Treffpunkt: Vor dem Rathaus in der Dachauer Altstadt)"
    ]
    @themen.each do |theme|
      ThemenTopic.create(:content_type => "Theme", :content => theme)
    end
    @exkursions.each do |exkursion|
      ThemenTopic.create(:content_type => "Exkursion", :content => exkursion)
    end
  end

  def self.down
  end
end
