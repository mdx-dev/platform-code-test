require 'award_quality_decay_processors'
require 'award'

class AwardQualityDailyDecayJob
  def self.update(award)
    return if award.nil?
    original_expires = award.expires_in

    award.decrement_expires_in

    award.decay_quality
  rescue StandardError => e
    # log the error somewhere
    award.expires_in = original_expires
  end
end
