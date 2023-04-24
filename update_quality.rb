require 'award_quality_daily_decay_job'

def update_quality(awards)
  awards.each do |award|
    AwardQualityDailyDecayJob.update(award)
  end
end
