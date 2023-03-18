require './award_quality_update_strategy'

class BlueStarStrategy < AwardQualityUpdateStrategy
    def update(award)
        if award.quality > 0 && award.expires_in > 0
           award.quality -= 2
        end
        
        award.expires_in -=1 

        if award.expires_in < 0 && award.quality > 0
           award.quality -= 4
        end

    end
end