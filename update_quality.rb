require 'award'

def update_quality(awards)
  awards.each do |award|
    award_type_class = case award.name
                       when 'NORMAL ITEM'
                         Normal
                       when 'Blue First'
                         BlueFirst
                       when 'Blue Distinction Plus'
                         BlueDistinctionPlus
                       when 'Blue Compare'
                         BlueCompare
                       when 'Blue Star'
                         BlueStar
                       end
    award_type_class.new(award).update
  end
end