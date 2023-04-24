module AwardQualityDecayProcessors
  class BlueFirst
    AWARD_NAME = 'Blue First'

    def self.decay(award)
      raise InvalidAward.new(award.name) unless award.name.eql? AWARD_NAME

      if award.quality < 50
        award.quality += 1
      end

      award.expires_in -= 1

      return if award.expires_in >= 0

      if award.quality < 50
        award.quality += 1
      end
    end
  end

  class BlueCompare
    AWARD_NAME = 'Blue Compare'

    def self.decay(award)
      raise InvalidAward.new(award.name) unless award.name.eql? AWARD_NAME

      # increment if the quality is currently less than 50
      if award.quality < 50
        award.quality += 1
      end

      # increment if the award expires in the next 11 days
      if award.expires_in < 11
        if award.quality < 50
          award.quality += 1
        end
      end

      # increment again if the award expires in the next 6 days
      if award.expires_in < 6
        if award.quality < 50
          award.quality += 1
        end
      end

      # decrement the expiration
      award.expires_in -= 1

      return if award.expires_in >= 0

      # set quality to zero if the award expires today
      award.quality = award.quality - award.quality
    end
  end

  class BlueDistinctionPlus
    AWARD_NAME = 'Blue Distinction Plus'

    def self.decay(award)
      raise InvalidAward.new(award.name) unless award.name.eql? AWARD_NAME
    end
  end

  class NormalItem
    AWARD_NAME = 'NORMAL ITEM'

    def self.decay(award)
      award.quality -= 1
      award.expires_in -= 1
      return if award.expires_in >= 0
      award.quality -= 1
    end

  end

  class BlueStar
    AWARD_NAME = 'Blue Star'

    def self.decay(award)
      award.quality -= 2
      award.expires_in -= 1
      return if award.expires_in >= 0
      award.quality -= 2
    end
  end

  class InvalidAward < StandardError
    def initialize(msg="")
      super(msg)
    end
  end
  
end