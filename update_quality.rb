require 'award'

def update_quality(awards)
  awards.each do |award|
    next if award.name == 'Blue Distinction Plus'
    case award.name
    when 'Blue First'
      award.expires_in -= 1
      award.quality += 1 if award.quality < 50
      award.quality += 1 if award.quality < 50 && award.expires_in < 0
    when 'Blue Compare'
      award.quality += 1 if award.quality < 50
      award.quality += 1 if award.expires_in < 11 && award.quality < 50
      award.quality += 1 if award.expires_in < 6 && award.quality < 50
      award.expires_in -= 1
      award.quality = 0 if award.expires_in < 0
    when 'Blue Star'
      award.quality -= 2 if award.quality > 0
      award.expires_in -= 1
      award.quality -= 2 if award.expires_in < 0
      award.quality = 0 if award.quality < 0
    else
      # handle normal awards
      award.quality -= 1 if award.quality > 0
      award.expires_in -= 1
      award.quality -= 1 if award.expires_in < 0 && award.quality > 0
    end
  end
end
