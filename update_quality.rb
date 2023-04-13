# frozen_string-literal: true

# update award functionality
def update_quality(awards)
  awards.each(&:update_quality)
end
