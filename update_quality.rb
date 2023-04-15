require 'award'

MAX_QUALITY = 50.freeze
MIN_QUALITY = 0.freeze

def update_quality(awards)
  awards.each do |award|
    # blue distinction plus never changes value or expires
    return if award.name == "Blue Distinction Plus"

    award.expires_in -= 1
    return if award.quality == MIN_QUALITY || award.quality == MAX_QUALITY

    case award.name
    when "Blue Compare"
      # no value after expiration date
      if award.expires_in < 0
        award.quality = MIN_QUALITY
        break
      end

      award.quality += 1

      # 5days or less, triple points! and today doesn't count
      if award.expires_in + 1 < 6
        award.quality += 2
      # 6-10 days, double points! and today doesn't count
      elsif award.expires_in + 1 < 11
        award.quality += 1
      end
    when "Blue First"
      # double points after expired
      award.quality += (award.expires_in < 0 ? 2 : 1)
    else
      multiplier = (award.name == "Blue Star" ? 2 : 1)
      # decrease double points for expired
      award.quality -= (award.expires_in < 0 ? 2*multiplier : 1*multiplier)
      award.quality = 0 if award.quality < MIN_QUALITY # reset if under 0
    end

    # reset if over 50
    award.quality = MAX_QUALITY if award.quality > MAX_QUALITY
  end
end
