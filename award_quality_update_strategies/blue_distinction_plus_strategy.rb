require './award_quality_update_strategy'

class BlueDistinctionStrategy < AwardQualityUpdateStrategy
    def update(award)
        # Never decreases in quality
    end
end