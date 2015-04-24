require 'award'

def update_quality(awards)
  awards.each do |award|
    award.expires_in -= 1
    if award.expires_in < 0
      expired = true
    else
      expired = false
    end
    case award.name
    when 'Blue First'
      award.quality += 1
      if expired
        award.quality += 1
      end
      if award.quality > 50
        award.quality = 50
      end
    when 'Blue Distinction Plus'
      award.quality = 80
# don't change expire date
      award.expires_in += 1
    when 'Blue Compare'
      if expired
        award.quality = 0
      else
        case award.expires_in + 1
        when (6..10)
          award.quality += 2
        when (0..5)
          award.quality += 3
        else
          award.quality += 1
        end
      end
      if award.quality > 50
        award.quality = 50
      end
    when 'Blue Star'
      if expired
        award.quality -= 4
      else
        award.quality -= 2
      end
    else
# default case for normal awards
      if expired
        award.quality -= 2
      else
        award.quality -= 1
      end
    end
    if award.quality < 0
      award.quality = 0
    end
  end
end
