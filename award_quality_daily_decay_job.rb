require 'award_quality_decay_processor'
require 'award'

class AwardQualityDailyDecayJob
  def self.update(award)
    processor = retrieve_processor(award)

    # decay the award
    processor.decay(award)

#     decrement expiration
#     # award.expires_in -= 1
# # 
#     additional decay for when award is expired
#     # processor.decay_expired(award)
  end

  def self.retrieve_processor(award)
    {
      'Blue First' => AwardQualityDecayProcessors::BlueFirst,
      'Blue Compare' => AwardQualityDecayProcessors::BlueCompare,
      'Blue Distinction Plus' => AwardQualityDecayProcessors::BlueDistinctionPlus,
      'NORMAL ITEM' => AwardQualityDecayProcessors::NormalItem
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