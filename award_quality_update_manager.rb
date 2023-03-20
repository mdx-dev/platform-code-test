require 'award'
require 'award_names'
Dir["./award_quality_update_strategies/*.rb"].each {|file| require file }

class AwardQualityUpdateManager 
    def self.get_strategy(award)
        case award.name
        when AwardNames::BLUE_COMPARE
            return BlueCompareStrategy.new

        when AwardNames::BLUE_DISTINCTION_PLUS
            return BlueDistinctionStrategy.new
        
        when AwardNames::BLUE_FIRST
            return BlueFirstStrategy.new
        
        when AwardNames::BLUE_STAR
            return BlueStarStrategy.new
        
        else
            return NormalStrategy.new
        end
    end

    def self.update(award)
        get_strategy(award).update(award)
    end
end