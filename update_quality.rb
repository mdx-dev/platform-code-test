require 'award'
require './award_quality_update_strategy'
require './award_quality_update_strategies/blue_compare_strategy'
require './award_quality_update_strategies/blue_distinction_plus_strategy'
require './award_quality_update_strategies/blue_star_strategy'
require './award_quality_update_strategies/ordinary_strategy'
require './award_quality_update_strategies/blue_first_strategy'

def update_quality(awards)
  awards.each do |award|
    AwardQualityUpdateStrategy.get_strategy(award).update(award)
  end
end