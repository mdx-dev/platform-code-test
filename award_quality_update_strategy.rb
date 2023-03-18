require 'award'
require 'award_names'

class AwardQualityUpdateStrategy 
    def update(award)
        raise NotImplementedError
    end

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
            return OrdinaryStrategy.new
        end
    end
end