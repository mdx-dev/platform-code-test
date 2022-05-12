# frozen_string_literal: true

require 'award'

def update_quality(awards)
  awards.each do |award|
    if !award.blue_first? && !award.blue_compare?
      if award.quality.positive?
        if !award.blue_distinction_plus?
          award.quality -= 1
          if award.blue_star?
            award.quality -= 1
          end
        end
      end
    else
      if award.quality < 50
        award.quality += 1
        if award.blue_compare?
          if award.expires_in < 11
            if award.quality < 50
              award.quality += 1
            end
          end
          if award.expires_in < 6
            if award.quality < 50
              award.quality += 1
            end
          end
        end
      end
    end

    award.expires_in -= 1 if !award.blue_distinction_plus?

    if award.expires_in.negative?
      if !award.blue_first?
        if !award.blue_compare?
          if award.quality.positive?
            if !award.blue_distinction_plus?
              award.quality -= 1
              if award.blue_star?
                award.quality -= 1
              end
            end
          end
        else
          award.quality = 0
        end
      else
        if award.quality < 50
          award.quality += 1
        end
      end
    end
  end
end
