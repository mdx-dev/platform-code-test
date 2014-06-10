class Award
  attr_reader :name, :updater
  attr_accessor :expires_in, :quality
  
  def initialize(name, expires_in, quality)
    @name, @expires_in, @quality = name, expires_in, quality
    @updater = case name
    when "NORMAL ITEM"
      NormalUpdater.new
    when "Blue First"
      BlueFirstUpdater.new
    when "Blue Compare"
      BlueCompareUpdater.new
    when "Blue Star"
      BlueStarUpdater.new
    else
      AwardUpdater.new
    end
  end

  def update
    updater.update(self)
  end

  def quality=(new_quality)
    @quality = if new_quality < 0
      0
    elsif new_quality > 50
      50
    else
      new_quality
    end
  end
end
