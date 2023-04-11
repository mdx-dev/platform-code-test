class BlueFirstUpdater
  def self.update(award)
    award.quality += 1 unless award.quality >= 50
    award.expires_in -= 1

    if award.expires_in < 0
      award.quality += 1 unless award.quality >= 50
    end

    award
  end

  def self.quality_increase_when_less_than(days, award)
    if award.expires_in < days
      award.quality += 1 unless award.quality >= 50
    end
  end
end
