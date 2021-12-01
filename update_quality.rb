require 'award'

def update_quality(awards)
  awards.each do |award|
    award.blue_first if award.name == "Blue First"
    award.blue_compare if award.name == "Blue Compare"
    award.blue_star if award.name == "Blue Star"
    award.normal_item if award.name == "NORMAL ITEM"
  end
end 