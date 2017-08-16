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

def update_quality(awards)
  awards.each do |award|
    return if blue_distinct_update(award)

    if award.name != 'Blue First' && award.name != 'Blue Compare'
      norm_update(award)
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          blue_compare_update(award)
        end
      end
    end

    award.expires_in -= 1

    if award.expires_in > 0 && award.quality > 0
      if award.name == 'Blue Star'
        award.quality -= 1
      end
    end

    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            award.quality -= 1
            if award.name == 'Blue Star'
              award.quality -= 2
            end
          end
        else
          award.quality = 0
        end
      else
        if award.quality < 50
          award.quality += 1
        end
      end
    end
  end
end
