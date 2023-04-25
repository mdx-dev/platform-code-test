require 'award'

class AwardQualityDailyDecayJob
  def self.update(award)
    return if award.nil?

    award.decrement_expires_in

    award.decay_quality
  rescue StandardError => e
    # log the error somewhere
    # implement some sort of award rollback/reset mechanism here
    raise(e)
  end
end
