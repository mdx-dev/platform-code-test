require 'award'

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue Distinction Plus'
      award.quality = limit_quality(award.quality, 80, 0)
    else
      case award.name
      when 'Blue Compare'
        case
        when award.expires_in <= 0
          award.quality = 0
        when (1..5).include?(award.expires_in)
          award.quality += 3
        when (6..10).include?(award.expires_in)
          award.quality += 2
        else
          award.quality += 1
        end
        award.quality = limit_quality(award.quality, 50, 0)

      when 'Blue First'
        case
        when award.expires_in <= 0
          award.quality += 2
        else
          award.quality += 1
        end
        award.quality = limit_quality(award.quality, 50, 0)

      when 'Blue Star'
      else
        if award.expires_in <= 0
          award.quality -= 2
        else
          award.quality -= 1
        end
        award.quality = limit_quality(award.quality, 50, 0)
      end
      award.expires_in -= 1
    end




    # if award.name != 'Blue First' && award.name != 'Blue Compare'
    #   if award.quality > 0
    #     if award.name != 'Blue Distinction Plus'
    #       award.quality -= 1
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
    #           award.quality -= 1
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
  end
end

def limit_quality(score, max, min)
  new_score = score
  if score > max
    new_score = max
  elsif score < min
    new_score = min
  end
  new_score
end