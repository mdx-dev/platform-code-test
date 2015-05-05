require 'award'

def update_quality(awards)
  awards.each do |award|
    
    # NORMAL ITEM    
    if award.name == 'NORMAL ITEM'
      award.expires_in -= 1
      return if award.quality == 0
      
      award.quality -= 1
      award.quality -= 1 if award.expires_in <= 0
    end

    # BLUE FIRST
    if award.name == 'Blue First'
      award.expires_in -= 1
      return if award.quality == 50
      
      award.quality += 1
      award.quality += 1 if award.expires_in <= 0 && award.quality < 50
    end

    # BLUE COMPARE
    if award.name == 'Blue Compare'
      award.expires_in -= 1
      return if award.quality >= 50
      return award.quality = 0 if award.expires_in < 0

      award.quality += 1
      award.quality += 1 if award.expires_in < 10 && award.quality < 50
      award.quality += 1 if award.expires_in < 5 && award.quality < 50
    end



    # if award.name != 'Blue First' && award.name != 'Blue Compare'
    #   if award.quality > 0
    #     if award.name == 'Blue Star'
    #       award.quality -= 2
    #     elsif award.name != 'Blue Distinction Plus'
    #       award.quality -= 1
    #     end
    #   end
    # elsif award.quality < 50
    #   award.quality += 1
    #   if award.name == 'Blue Compare'
    #     if award.expires_in < 11
    #       if award.quality < 50
    #         award.quality += 1
    #       end
    #     end
    #     if award.expires_in < 6
    #       if award.quality < 50
    #         award.quality += 1
    #       end
    #     end
    #   end
    # end
    # if award.name != 'Blue Distinction Plus'
    #   award.expires_in -= 1
    # end
    # if award.expires_in < 0
    #   if award.name != 'Blue First'
    #     if award.name != 'Blue Compare'
    #       if award.quality > 0
    #         if award.name != 'Blue Distinction Plus'
    #           if award.name == 'Blue Star'
    #             award.quality -= 2
    #           elsif
    #             award.quality -= 1
    #           end
    #         end
    #       end
    #     else
    #       award.quality = award.quality - award.quality
    #     end
    #   elsif award.quality < 50
    #     award.quality += 1
    #   end
    # end
  end
end
