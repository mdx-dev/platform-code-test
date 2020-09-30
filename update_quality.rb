require 'award'
require 'pry'

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue First'
      if award.quality < 50
        award.quality += 1
      end
    when 'Blue Compare'
      if (6..10).include?(award.expires_in)
        award.quality += 2
      elsif (1..5).include?(award.expires_in)
        award.quality += 3
      elsif award.expires_in <= 0
        award.quality = 0
      else
        award.quality += 1
      end
    else

      if award.expires_in > 0
        if award.quality > 0
          award.quality -= 1
        end
      else
        award.quality -= 2
      end

    end

    award.expires_in -= 1
  end

  # awards.each do |award|
  #   if award.name != 'Blue First' && award.name != 'Blue Compare'
  #     if award.quality > 0
  #       if award.name != 'Blue Distinction Plus'
  #         award.quality -= 1
  #       end
  #     end
  #   else
  #     if award.quality < 50
  #       award.quality += 1
  #       if award.name == 'Blue Compare'
  #         if award.expires_in < 11
  #           if award.quality < 50
  #             award.quality += 1
  #           end
  #         end
  #         if award.expires_in < 6
  #           if award.quality < 50
  #             award.quality += 1
  #           end
  #         end
  #       end
  #     end
  #   end
  #   if award.name != 'Blue Distinction Plus'
  #     award.expires_in -= 1
  #   end
  #   if award.expires_in < 0
  #     if award.name != 'Blue First'
  #       if award.name != 'Blue Compare'
  #         if award.quality > 0
  #           if award.name != 'Blue Distinction Plus'
  #             award.quality -= 1
  #           end
  #         end
  #       else
  #         award.quality = award.quality - award.quality
  #       end
  #     else
  #       if award.quality < 50
  #         award.quality += 1
  #       end
  #     end
  #   end
  # end
end
