class BlueFirstUpdater < AwardUpdater
  def update(award)
    award.expires_in -= 1
    award.quality += (award.expires_in < 1 ? 2 : 1)
  end
end