class Award
  attr_reader :name, :updater
  attr_accessor :expires_in, :quality
  UPDATER_CLASSES = {
    "NORMAL ITEM" => NormalUpdater,
    "Blue First" => BlueFirstUpdater,
    "Blue Compare" => BlueCompareUpdater,
    "Blue Star" => BlueStarUpdater
  }
  
  def initialize(name, expires_in, quality)
    @name, @expires_in, @quality = name, expires_in, quality
    @updater = UPDATER_CLASSES.fetch(name, AwardUpdater).new
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
