require 'award'

def update_quality(awards)
  awards.each do |award|
    create_award_type(award).update_attributes
  end
end

def create_award_type(award)
  case award.name
  when 'NORMAL ITEM'
    Normal.new(award)
  when 'Blue First'
    BlueFirst.new(award)
  when 'Blue Distinction Plus'
    AwardType.new(award)
  when 'Blue Compare'
    BlueCompare.new(award)
  when 'Blue Star'
    BlueStar.new(award)
  else
    raise "Unknown award type: #{award.name}"
  end
end