require 'award_quality_decay_processor'

class AwardQualityDailyDecayJob
  def self.update(award)
    if award.name.eql? 'Blue First'
      # decay the award
      AwardQualityDecayProcessor.decay(award)

      # decrement expiration
      award.expires_in -= 1

      # additional decay when award is expired
      AwardQualityDecayProcessor.decay_when_expired(award)
    end
  end
end