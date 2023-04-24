require 'award'
require 'award_quality_daily_decay_job'

def update_quality(awards)
  awards.each do |award|

    if ['Blue First', 'Blue Compare'].include? award.name
      AwardQualityDailyDecayJob.update(award)
      return
    end

    # "standard" quality decay
    if award.name != 'Blue First' && award.name != 'Blue Compare'
      if award.quality > 0
        if award.name != 'Blue Distinction Plus'
          if award.name.eql?("Blue Star")
            award.quality -= 2
          else
            award.quality -= 1
          end
        end
      end
    else # Blue First & Blue Compare
      if award.quality < 50
        award.quality += 1
        if award.name == 'Blue Compare'
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


    if award.name != 'Blue Distinction Plus'
      award.expires_in -= 1
    end



    # additional expired quality decay
    if award.expires_in < 0
      if award.name != 'Blue First'
        if award.name != 'Blue Compare'
          if award.quality > 0
            if award.name != 'Blue Distinction Plus'
              if award.name.eql? 'Blue Star'
                award.quality -= 2
              else
                award.quality -= 1
              end
            else # award is Blue Distinction Plus
            end
          end
        else # award is Blue Compare
          award.quality = award.quality - award.quality
        end
      else # award is Blue First
        if award.quality < 50
          award.quality += 1
        end
      end
    end
  end
end
