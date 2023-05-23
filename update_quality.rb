require 'award'

def update_quality(awards)
  white_list_for_rewards = ['Blue First', 'Blue Compare', 'Blue Distinction Plus']
  awards.each do |award|
    if !white_list_for_rewards.include?(award.name)
      award.decrease_quality(1) if !award.quality.zero? && award.name != 'Blue Star'
      award.decrease_quality(2) if !award.quality.zero? && award.name == 'Blue Star'
    else
      award.increase_quality(1) if award.quality < 50
      if award.name == 'Blue Compare'
        award.increase_quality(1) if award.expires_in < 11 && award.quality < 50
        award.increase_quality(1) if award.expires_in < 6 && award.quality < 50
      end
    end

    award.expires_in -= 1 if award.name != 'Blue Distinction Plus'

    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          award.decrease_quality(1) if award.name != 'Blue Distinction Plus' && award.quality > 0 && award.name != 'Blue Star'
          award.decrease_quality(2) if award.name == 'Blue Star' && award.quality > 0
        else
          award.quality = award.quality - award.quality
        end
      end
      award.increase_quality(1) if award.name == 'Blue First' && award.quality < 50
    end
  end
end
