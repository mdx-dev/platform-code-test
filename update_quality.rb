require 'award'
require 'blue_first'
require 'blue_distinction_plus'
require 'blue_compare'
require 'blue_star'

def update_quality(awards)
  awards.each {|award| award.update_quality}
end
