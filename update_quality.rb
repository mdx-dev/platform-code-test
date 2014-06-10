require 'award'
require 'award_updater'
require 'normal_updater'
require 'blue_first_updater'
require 'blue_compare_updater'
require 'blue_star_updater'

def update_quality(awards)
  awards.each(&:update)
end
