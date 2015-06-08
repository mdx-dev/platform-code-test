require 'award'

def update_quality(awards)
  awards.each do |award|
    award_name=award.name

    case award_name

     when 'Blue Star'
        if award.quality >= 2
         award.quality -= 2
        else
         award.quality = 0
        end
        award.expires_in -= 1
        if award.expires_in < 0
         if award.quality >= 2
           award.quality -= 2
         else
          award.quality = 0
         end
        end

     when 'Blue First' 
        if award.quality < 50
          award.quality += 1
        end
        award.expires_in -= 1
        if award.expires_in < 0
          if award.quality < 50
            award.quality += 1
          end
        end

     when 'Blue Compare'
        if award.quality < 50
           award.quality += 1
        end
        if (award.expires_in < 6) 
            if award.quality < 48
              award.quality += 2 
            else
              award.quality = 50
            end
        else 
          if award.expires_in < 11
            if award.quality < 49
              award.quality += 1 
            else
              award.quality = 50
            end
          end
        end
        award.expires_in -= 1
        if award.expires_in < 0
          if award.quality > 0
            award.quality = 0
          end
        end

      when 'Blue Distinction Plus'
       # do not change quality;
       ;
     else
      if award.quality > 0
          award.quality -= 1
      end
      award.expires_in -= 1
      if award.expires_in < 0
        if award.quality > 0
          award.quality -= 1
        end
      end
    end
  end
end
