module AwardQualityDecayProcessors

  def retrieve_processor(award)
    processor_class = {
      'Blue First' => BlueFirst,
      'Blue Compare' => BlueCompare,
      'Blue Distinction Plus' => BlueDistinctionPlus,
      'NORMAL ITEM' => NormalItem,
      'Blue Star' => BlueStar
    }.fetch(self.name) do |award_name|
      raise(AwardQualityDecayProcessors::UnknownProcessor.new("No decay processor found for: #{award_name}"))
    end

    processor_class.new(award)
  end
  class BlueFirst
    VALID_AWARD_NAME = 'Blue First'
    DECAY_AMOUNT = 1

    attr_accessor :award

    def initialize(award)
      return if award.nil?

      raise InvalidAward.new(award.name) unless award.name.eql? VALID_AWARD_NAME

      self.award = award
    end

    def decay
      self.award.quality += DECAY_AMOUNT

      return if self.award.expires_in >= 0

      self.award.quality += DECAY_AMOUNT
    end
  end

  class BlueCompare
    VALID_AWARD_NAME = 'Blue Compare'
    DECAY_AMOUNT = 1

    attr_accessor :award

    def initialize(award)
      return if award.nil?

      raise InvalidAward.new(award.name) unless award.name.eql? VALID_AWARD_NAME

      self.award = award
    end

    def decay
      self.award.quality += DECAY_AMOUNT
      
      # decay again
      self.award.quality += DECAY_AMOUNT if self.award.expires_in < 10
      
      # decay again again
      self.award.quality += DECAY_AMOUNT if self.award.expires_in < 5

      return if self.award.expires_in >= 0

      # set quality to zero if the award is expired
      self.award.quality = 0
    end
  end

  class BlueDistinctionPlus
    VALID_AWARD_NAME = 'Blue Distinction Plus'
    DECAY_AMOUNT = 0

    attr_accessor :award

    def initialize(award)
      return if award.nil?

      raise InvalidAward.new(award.name) unless award.name.eql? VALID_AWARD_NAME

      self.award = award
    end

    def decay; end
  end

  class NormalItem
    VALID_AWARD_NAME = 'NORMAL ITEM'
    DECAY_AMOUNT = 1

    attr_accessor :award

    def initialize(award)
      return if award.nil?

      raise InvalidAward.new(award.name) unless award.name.eql? VALID_AWARD_NAME

      self.award = award
    end

    def decay
      self.award.quality -= DECAY_AMOUNT
      return if self.award.expires_in >= 0

      self.award.quality -= DECAY_AMOUNT
    end

  end

  class BlueStar
    VALID_AWARD_NAME = 'Blue Star'
    DECAY_AMOUNT = 2

    attr_accessor :award

    def initialize(award)
      return if award.nil?

      raise InvalidAward.new(award.name) unless award.name.eql? VALID_AWARD_NAME

      self.award = award
    end

    def decay
      self.award.quality -= DECAY_AMOUNT
      return if self.award.expires_in >= 0

      self.award.quality -= DECAY_AMOUNT
    end
  end

  class InvalidAward < StandardError
    def initialize(msg="")
      super(msg)
    end
  end

  class UnknownProcessor < StandardError
    def initialize(msg="")
      super(msg)
    end
  end
  
end