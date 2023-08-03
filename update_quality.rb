require 'award'

def update_quality(awards)
  awards.each do |award|
    award.update_quality
  end
end