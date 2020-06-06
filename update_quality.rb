require 'award'

def update_quality(awards)
  awards.each do |award|
    award.update_type
  end
end
