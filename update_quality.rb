require 'award'

def update_quality(awards)

  awards.each do |award| #awards is an array

    if award.name != 'Blue First' && award.name != 'Blue Compare' # Checking if it is a normal award
      if award.quality > 0 # Checking that its quality is not already the minimum (0)
        if award.name != 'Blue Distinction Plus' # You can't reduce the quality of Blue Plus
          award.quality -= 1 # If it gets here it means it's a normal award
        end
      end

    else
      if award.quality < 50 # Some awards increase their quality everyday, check if not already at max(50)
        award.quality += 1
        if award.name == 'Blue Compare' # Blue Compare has special conditions around expiration date
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1 # Increase an extra point if exp date within 10 days
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1 # Another extra point if exp date within 5 days
            end
          end
        end
      end
    end
    if award.name != 'Blue Distinction Plus' # Blue Plus never expires
      award.expires_in -= 1
    end
    if award.expires_in < 0 # Functionality after an award expires
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
              award.quality -= 1 # If it's a normal award; it loses one point of quality
            end
          end
        else
          award.quality = award.quality - award.quality # If it is Blue Compare, its quality drops to 0 after exp date
        end
      else
        if award.quality < 50
          award.quality += 1 # All other awards increase quality(except Blue Plus) unless at max.
        end
      end
    end

  end

end
