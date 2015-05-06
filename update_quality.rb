require 'award'
require 'award_types'

def update_quality(awards)
  awards.each do |award|
    award.update_type
  end
end
