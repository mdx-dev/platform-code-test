require 'award'

def update_quality(awards)
  awards.each do |award|
    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
          award.quality -= 1
          if award.name == 'Blue Star' and award.quality > 0
              award.quality -=1
          end
        end
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in <= 10
            if award.quality < 50
              award.quality += 1
            end
          end
          if award.expires_in <= 5
            if award.quality < 50
              award.quality += 1
            end
          end
        end
      end
    end
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
              award.quality -= 1
            end
            if award.name == 'Blue Star'
              if award.quality > 0
                award.quality -=1
              end
            end
          end
        else
          award.quality = award.quality - award.quality
        end
      else
        if award.quality < 50
          award.quality += 1
        end
      end
    end
  end
end
