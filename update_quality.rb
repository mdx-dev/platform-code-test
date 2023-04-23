require 'award'

def update_quality(awards)
  awards.each do |award|
    case award.name
    when 'NORMAL ITEM'
      Normal.new(award).update
    when 'Blue First'
      BlueFirst.new(award).update
    when 'Blue Distinction Plus'
      BlueDistinction.new(award).update
    when 'Blue Compare'
      BlueCompare.new(award).update
    when 'Blue Star'
      BlueStar.new(award).update
    end
  end
end