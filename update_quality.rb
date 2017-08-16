require_relative 'award'

def blue_star_update(award)
  if award.expires_in > 1 && award.expires_in < 6
    award.quality -= 1
  end
  if award.expires_in == 1
    award.quality -= 3
  end
end

def norm_update(award)
  if award.quality > 0
    return award.quality -= 1
  end
end

def blue_distinct_update(award)
  if award.name == 'Blue Distinction Plus'
    return award.quality
  end
end

def blue_compare_update(award)
  if award.expires_in < 11 && award.quality < 50
    award.quality += 1
  end
  if award.expires_in < 6 && award.quality < 50
    award.quality += 1
  end
end

def blue_star_update_before_expiration(award)
  if award.expires_in > 0 && award.quality > 0
    if award.name == 'Blue Star'
      award.quality -= 1
    end
  end
end

def expired_updates(award)
  if award.expires_in < 0 && award.name == 'Blue Compare'
    return award.quality = 0
  end

  if award.expires_in < 0 && award.quality < 50 && award.name == 'Blue First'
    award.quality += 1
  else
    if award.expires_in < 0 && award.name != 'Blue First' && award.quality > 0
      award.quality -= 1
      if award.name == 'Blue Star'
        award.quality -= 2
      end
    end
  end
end

def check_for_under_50(award)
  if award.quality < 50
    award.quality += 1
    if award.name == 'Blue Compare'
      blue_compare_update(award)
    end
  end
end

def update_quality(awards)
  high_awards = ['Blue First', 'Blue Compare']
  awards.each do |award|
    return if blue_distinct_update(award)

    if !high_awards.include?(award.name)
      norm_update(award)
    else
      check_for_under_50(award)
    end
    award.expires_in -= 1
    blue_star_update_before_expiration(award)
    expired_updates(award)
  end
end
