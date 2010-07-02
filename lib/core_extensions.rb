class Date

  # return today based on timezone
  def self.today_timezone
    Date.parse(Time.zone.now.strftime("%a, %d %m %Y"))
  end
end