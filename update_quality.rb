require 'award'
require 'updaters/blue_first_up'
require 'updaters/blue_comp_up'
require 'updaters/blue_star_up'
require 'updaters/blue_dist_plus_up'
require 'contraints/value_constraint'
require 'contraints/exception'

def update_quality(awards)
  awards.each do |award|
    
    case award.name
    #Blue Compare Award
    when 'Blue Compare'
      BlueCompare.new.update_quality(award)

    when 'Blue Star'
      BlueStar.new.update_quality(award)
    
    # Blue First Award
    when 'Blue First'
      BlueFirst.new.update_quality(award)

    # Blue Distinction Plus Award
    else
      BlueDistinctionPlus.new.update_quality(award)
    end

  # Sets qaulity to range 0-50
  ValueConstraint.new.update_quality(award)
  # Ecxeption for Blue Distinction Plus quaility decreasement
  Exception.new.update_quality(award)
  end
end