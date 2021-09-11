require 'award'

def blue_first(award)
  award.expires_in -= 1
  if award.quality < 50
    award.quality += 1
  end
  if award.expires_in < 0 && award.quality < 50
    award.quality += 1
  end
end

def blue_compare(award)
  award.expires_in -= 1
  if award.quality == 50
    return award.quality = 50
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
  return
end

def blue_star(award)
  award.expires_in -= 1
  if award.quality > 0
    award.quality -= 2
  end
end

def normal_item(award)
  award.expires_in -= 1
  if award.quality == 0
    return
  end
  if award.expires_in > 0
    award.quality -= 1
  elsif award.expires_in == 0
    award.quality -= 2
  else
    award.quality -= 2
  end
end

def update_quality(awards)
  awards.each do |award|
    if award.name == 'Blue First'
      blue_first(award)
    elsif award.name == 'Blue Compare'
      blue_compare(award)
    elsif award.name == 'Blue Star'
      blue_star(award)
    elsif award.name == 'Blue Distinction Plus'
      blue_distinction_plus(award)
    else
      normal_item(award)
    end
    if award.quality < 0
      award.quality = 0
    end
  end
end
