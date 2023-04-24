require 'award_quality_decay_processors'
require 'award'

class AwardQualityDailyDecayJob
  def self.update(award)
    return if award.nil?

    award.decrement_expires_in
    award.quality_decay_processor.decay(award)

  end
end
