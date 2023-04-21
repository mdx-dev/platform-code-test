class BlueDistinctionPlus
  def update_quality(award)
    award.quality -= 1
    award.quality -= 1 if award.expires_in <= 0
  end
  
end