class BlueCompareUpdater 
  def self.update(award)
    award.quality += 1 unless award.quality >= 50
    quality_increase_when_less_than(11, award)
    quality_increase_when_less_than(6, award)

    award.expires_in -= 1

    if award.expires_in < 0
      award.quality = 0
    end

    award
  end

  def self.quality_increase_when_less_than(days, award)
    if award.expires_in < days
      award.quality += 1 unless award.quality >= 50
    end
  end
end