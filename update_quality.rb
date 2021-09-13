require 'award'

def blue_first(award)
  if award.name != 'Blue First'
    return 
  end
  if award.quality < 50
    award.quality += 1
  end
  if award.expires_in < 0 && award.quality < 50
    award.quality += 1
  end
end

def blue_compare(award)
  if award.name != 'Blue Compare' or award.quality == 50
    return 
  end

  if award.expires_in > 9
    award.quality += 1
  elsif award.expires_in > 4
    award.quality += 2
  elsif award.expires_in > -1
    award.quality += 3
  end

  if award.expires_in < 0
    award.quality = 0
  end
end

def blue_distinction_plus(award)
  if award.name != 'Blue Distinction Plus'
    return 
  end
  award.expires_in += 1
end

def blue_star(award)
  if award.name != 'Blue Star' or award.quality == 0
    return 
  end
  
  if award.expires_in > 0
    award.quality -= 2
  elsif award.expires_in <= 0
    award.quality -= 4
  end    

end

def normal_item(award)
  if award.name != 'NORMAL ITEM' or award.quality == 0
    return 
  end
  
  if award.expires_in > 0
    award.quality -= 1
  else
    award.quality -= 2
  end
end

def update_quality(awards)
  awards.each do |award|
    award.expires_in -= 1
      blue_first(award)
      blue_compare(award)
      blue_star(award)
      blue_distinction_plus(award)
      normal_item(award)
    if award.quality <= 0
      award.quality = 0
    end
  end
end
