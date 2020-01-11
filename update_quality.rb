# frozen_string_literal: true

require 'award'

def update_quality(awards)
  awards.each do |award|
    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        award.quality -= 1 if award.name != 'Blue Distinction Plus'
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            award.quality += 1 if award.quality < 50
          end
          if award.expires_in < 6
            award.quality += 1 if award.quality < 50
          end
        end
      end
    end
    award.expires_in -= 1 if award.name != 'Blue Distinction Plus'
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            award.quality -= 1 if award.name != 'Blue Distinction Plus'
          end
        else
          award.quality = award.quality - award.quality
        end
      else
        award.quality += 1 if award.quality < 50
      end
    end
  end
end
