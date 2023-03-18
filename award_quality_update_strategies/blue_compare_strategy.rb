require './award_quality_update_strategy'

class BlueCompareStrategy < AwardQualityUpdateStrategy
    def update(award)

        # Quality drops to 0 after expiration
        if award.quality < 50
            award.quality += 1
            if award.expires_in < 11
              award.quality += 1
            end
            if award.expires_in < 6
              award.quality += 1
            end
        end

        award.expires_in -= 1

        if award.expires_in < 0
            award.quality = 0
        end
    end 
end