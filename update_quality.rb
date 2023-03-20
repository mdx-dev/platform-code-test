require 'award'
require 'award_quality_update_manager'

def update_quality(awards)
  awards.each do |award|
    AwardQualityUpdateManager.update(award)
  end
end