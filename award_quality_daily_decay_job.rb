require 'award_quality_decay_processors'
require 'award'

class AwardQualityDailyDecayJob
  def self.update(award)
    processor = retrieve_processor(award)

    award.decrement_expires_in

    processor.decay(award)
  end

  def self.retrieve_processor(award)
    {
      'Blue First' => AwardQualityDecayProcessors::BlueFirst,
      'Blue Compare' => AwardQualityDecayProcessors::BlueCompare,
      'Blue Distinction Plus' => AwardQualityDecayProcessors::BlueDistinctionPlus,
      'NORMAL ITEM' => AwardQualityDecayProcessors::NormalItem,
      'Blue Star' => AwardQualityDecayProcessors::BlueStar
    }.fetch(award.name) do |award_name|
      raise(UnknownAwardQualityDecayProcessor.new("No decay processor found for: #{award_name}"))
    end
  end
end

class UnknownAwardQualityDecayProcessor < StandardError
  def initialize(msg="")
    super(msg)
  end
end