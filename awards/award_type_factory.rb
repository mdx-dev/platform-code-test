require 'award'
Dir.glob('awards/*.rb').each { |file| require file }

class AwardTypeFactory
  AWARD_TYPES_MAPPING = {
    'NORMAL ITEM' => Normal,
    'Blue First' => BlueFirst,
    'Blue Distinction Plus' => AwardType,
    'Blue Compare' => BlueCompare,
    'Blue Star' => BlueStar
  }.freeze

  def self.create_award_type_instance(award)
    award_type = AWARD_TYPES_MAPPING[award.name]
    raise "Unknown award type: #{award.name}" unless award_type

    award_type.new(award)
  end
end
