require 'award'


def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue First'
      award.expires_in -= 1
      award.quality += 1 if award.quality < 50
      award.quality += 1 if award.expires_in < 0 && award.quality < 50
    when 'Blue Compare'
      award.expires_in -= 1
      award.quality += 1 if award.quality < 50
      award.quality += 1 if award.expires_in < 10 && award.quality < 50
      award.quality += 1 if award.expires_in < 5 && award.quality < 50
      award.quality = 0 if award.expires_in < 0
    when 'Blue Star'
      award.expires_in -= 1
      award.quality -= 2 if award.quality > 0
      award.quality -= 2 if award.expires_in < 0 && award.quality > 0
    when 'Blue Distinction Plus'
      nil # Do nothing, quality and expiration dates remain constant
    else
      award.expires_in -= 1
      award.quality -= 1 if award.quality > 0
      award.quality -= 1 if award.expires_in < 0 && award.quality > 0
    end
  end 
end