require 'award'


def update_quality(awards)
  awards.each do |a|
    if a.name != 'Blue Distinction Plus'
      a.expires_in -= 1
          case a.name
              when 'Blue First'
                a.increment(1)
              when 'Blue Compare'
                if a.expired?
                    a.quality = 0
                elsif a.expires_in < 5
                    a.quality += 3
                elsif a.expires_in < 10
                    a.quality += 2
                else
                    a.quality += 1
                end  
              when 'NORMAL ITEM'          
                a.increment(-1)

              when 'Blue Star'
                a.increment(-2)
          end
      if a.quality > 50
        a.quality = 50
      elsif a.quality < 0
        a.quality = 0
      end
    end
  end
end


    # puts award
    # if award.name != 'Blue First' && award.name != 'Blue Compare'
    #   if award.quality > 0
    #     if award.name != 'Blue Distinction Plus'
    #       if award.name == 'Blue Star'
    #         award.quality -= 2 
    #       else
    #         award.quality -= 1
    #       end
    #     end
    #   end
    # else
    #   if award.quality < 50
    #     award.quality += 1
    #     if award.name == 'Blue Compare'
    #       if award.expires_in < 11
    #         if award.quality < 50
    #           award.quality += 1
    #         end
    #       end
    #       if award.expires_in < 6
    #         if award.quality < 50
    #           award.quality += 1
    #         end
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
    #           else
    #             award.quality -= 1 
    #           end
    #         end
    #       end
    #     else
    #       award.quality = award.quality - award.quality
    #     end
    #   else
    #     if award.quality < 50
    #       award.quality += 1
    #     end
    #   end
    # end
    #   puts award
