require 'award'

def update_quality(awards)
  awards.each do |award|
    award.calculate_quality_value
    award.update_expire_date
    
  end
end
