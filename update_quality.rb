require_relative 'award.rb'

def update_quality(awards)
  awards.each do |award|
    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus' && award.name != 'Blue Star'
          award.quality -= 1
        end
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1
            end
          end
        end
      end
    end

    # Logic to decrement the award.expires_in field
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
    if award.name == 'Blue Star'
      # if award.quality > 0
      if award.quality <= 0
          award.quality = award.quality - award.quality
      else
        if award.expires_in >= 0
          award.quality -= 2
          # award.quality -= 2
        else
          if award.expires_in < 0
          award.quality -= 4
          # award.quality -= 4
          end
        end
      end
    end
  end
end
