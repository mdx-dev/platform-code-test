module AwardQualityDecayProcessors
  class BlueFirst
    AWARD_NAME = 'Blue First'
    DECAY_AMOUNT = 1

    def self.decay(award)
      raise InvalidAward.new(award.name) unless award.name.eql? AWARD_NAME

      award.quality += DECAY_AMOUNT

      return if award.expires_in >= 0

      award.quality += DECAY_AMOUNT
    end
  end

  class BlueCompare
    AWARD_NAME = 'Blue Compare'
    DECAY_AMOUNT = 1

    def self.decay(award)
      raise InvalidAward.new(award.name) unless award.name.eql? AWARD_NAME

      award.quality += DECAY_AMOUNT
      
      # decay again
      award.quality += DECAY_AMOUNT if award.expires_in < 10
      
      # decay again again
      award.quality += DECAY_AMOUNT if award.expires_in < 5

      return if award.expires_in >= 0

      # set quality to zero if the award is expired
      award.quality = 0
    end
  end

  class BlueDistinctionPlus
    AWARD_NAME = 'Blue Distinction Plus'
    DECAY_AMOUNT = 0

    def self.decay(award)
      raise InvalidAward.new(award.name) unless award.name.eql? AWARD_NAME
      # there's nothing to do here
      # this doesn't change once created
    end
  end

  class NormalItem
    AWARD_NAME = 'NORMAL ITEM'
    DECAY_AMOUNT = 1

    def self.decay(award)
      award.quality -= DECAY_AMOUNT
      return if award.expires_in >= 0

      award.quality -= DECAY_AMOUNT
    end

  end

  class BlueStar
    AWARD_NAME = 'Blue Star'
    DECAY_AMOUNT = 2

    def self.decay(award)
      award.quality -= DECAY_AMOUNT
      return if award.expires_in >= 0

      award.quality -= DECAY_AMOUNT
    end
  end

  class InvalidAward < StandardError
    def initialize(msg="")
      super(msg)
    end
  end
  
end