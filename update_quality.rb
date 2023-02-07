require 'award'

def update_quality(awards)
  awards.each(&:update_quality)
end
