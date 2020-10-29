require_relative 'award'

def update_quality(awards)
  awards.each do |award|
    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
          award.quality -= 1
        end

      #  Before the expiration date depreciate Blue Star award quality by 1
        if award.name == 'Blue Star'
          award.quality -= 1
        end
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
          # changed from less than 11 to less than or equal 10, because readme specified
          # that the quality increases by 2 when there are 10 days or less left
          if award.expires_in <= 10
            if award.quality < 50
              award.quality += 1
            end
          end

          # changed from less than 6 to less than or equal to 5, because the  readme specified
          # that the quality increases by 3 when there are 10 days or less left
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