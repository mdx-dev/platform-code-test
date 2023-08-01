require 'award'

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'Blue First'
      award.quality = [award.quality + 1, 50].min
    when 'Blue Compare'
      award.quality = [award.quality + 1, 50].min
      award.quality = [award.quality + 1, 50].min if award.expires_in < 11
      award.quality = [award.quality + 1, 50].min if award.expires_in < 6
    when 'Blue Star'
      award.quality -= 2
    else
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
          award.quality -= 1
        end
      end
    end

    award.quality = [award.quality, 0].max

    unless award.name == 'Blue Distinction Plus'
      award.expires_in -= 1
    end

    if award.expires_in < 0
      case award.name
      when 'Blue First'
        award.quality = [award.quality + 1, 50].min
      when 'Blue Compare'
        award.quality = award.quality - award.quality
      when 'Blue Star'
        award.quality -= 2
      else
        if award.quality > 0
          if award.name != 'Blue Distinction Plus'
            award.quality -= 1
          end
        end
      end
    end
  end
end
