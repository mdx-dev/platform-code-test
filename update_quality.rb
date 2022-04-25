require 'award'

def update_quality(awards)
  awards.each do |award|
    award.process_award
  end
end