require 'award'

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue First'
      award.quality += 1
      award.quality += 1 if award.expires_in <= 0
    when 'Blue Compare'
      award.quality += 1
      award.quality += 1 if award.expires_in <= 10
      award.quality += 1 if award.expires_in <= 5
      award.quality = 0 if award.expires_in <= 0
    when 'Blue Star'
      award.quality -= 2
      award.quality -= 2 if award.expires_in <= 0
    else
      next if award.name == 'Blue Distinction Plus'

      award.quality -= 1
      award.quality -= 1 if award.expires_in <= 0
    end

    # Keep quality value within range (0..50)
    award.quality = 0 if award.quality < 0
    award.quality = 50 if award.quality > 50 && award.name != 'Blue Distinction Plus'

    # Decrease expiration days for all awards except Blue Distinction Plus
    award.expires_in -= 1 if award.name != 'Blue Distinction Plus'
  end
end
