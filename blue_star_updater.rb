class BlueStarUpdater < AwardUpdater
  def update(award)
    award.expires_in -= 1
    award.quality -= (award.expires_in < 1 ? 4 : 2)
  end
end