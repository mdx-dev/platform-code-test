class BlueFirst
  def update_quality(award)
    #increase quality as expires_in increases
    award.quality += 1
    award.quality += 1 if award.expires_in <= 0
  end
 
end

