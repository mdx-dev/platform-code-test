require 'award'

def update_quality(awards)
  awards.each do |award|
    award_name=award.name
    case award_name
     when 'Blue Star'
        award.quality -= award.quality >= 2 ? 2 : 0
        award.expires_in -= 1
        if award.expires_in < 0
          award.quality -= award.quality >= 2 ? 2 : 0
        end

     when 'Blue First' 
        award.quality += award.quality < 50 ? 1 : 0
        award.expires_in -= 1
        if award.expires_in < 0
          award.quality += award.quality < 50 ? 1 : 0
        end

     when 'Blue Compare'
        award.quality +=  award.quality < 50 ? 1 : 0
        if (award.expires_in < 6) 
             award.quality = award.quality < 48 ? award.quality+2 : 50
        else 
          if award.expires_in < 11
             award.quality = award.quality < 49 ? award.quality+1 : 50
          end
        end
        award.expires_in -= 1
        if award.expires_in < 0
           award.quality = award.quality > 0 ? 0 : award.quality
        end

      when 'Blue Distinction Plus'
       # do not change quality; and do not decrease expires_in 
       ;

     else
      award.quality -= award.quality > 0 ? 1 : 0
      award.expires_in -= 1
      if award.expires_in < 0
        award.quality -= award.quality > 0 ? 1 : 0
      end
    end
  end
end
