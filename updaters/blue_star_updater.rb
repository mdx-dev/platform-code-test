class BlueStarUpdater
  def self.update(award)
    quality_degradation_rate = 2 * (award.expires_in <= 0 ? 2 : 1)

    award.quality -= quality_degradation_rate
    award.quality = 0 if award.quality < 0
    
    award.expires_in -= 1
  end
end
