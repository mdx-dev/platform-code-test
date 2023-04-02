require 'award'

def update_quality(awards)
  awards.each do |award|
    #UserStory: Handle Blue Star Award here to lose quality value twice as fast as normal awards.
    if award.name == 'Blue Star'
      if award.quality > 0
        if award.expires_in > 0
          degradation_factor = 2  
        else
          degradation_factor = 4
        end
        award.quality -= degradation_factor
      end
    elsif award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
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
    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            awardsNameArr = ['Blue Distinction Plus', 'Blue Star']
            if !(awardsNameArr.include? award.name)
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
  end
end
