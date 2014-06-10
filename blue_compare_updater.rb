class BlueCompareUpdater < AwardUpdater
  def update(award)
    award.expires_in -= 1
    award.quality += 1
    award.quality += 1 if award.expires_in < 10
    award.quality += 1 if award.expires_in < 5
    award.quality = 0 if award.expires_in < 0
  end
end