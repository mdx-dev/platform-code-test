require 'award'
Dir[File.join(__dir__, 'updaters', '*.rb')].each { |file| require file }

def update_quality(awards)  
  awards.each do |award|
    case award.name
    when "Blue First"
      BlueFirstUpdater.update(award)
    when "Blue Compare"
      BlueCompareUpdater.update(award)
    when "Blue Distinction Plus"
      BlueDistinctionPlusUpdater.update(award)
    when "Blue Star"
      BlueStarUpdater.update(award)
    else
      GenericAwardUpdater.update(award)
    end
  end
end
