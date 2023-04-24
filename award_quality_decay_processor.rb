class AwardQualityDecayProcessor
  def self.decay(award)
    if award.name.eql? 'Blue First'
      if award.quality < 50
        award.quality += 1
      end
    end
  end

  def self.decay_when_expired(award)
    return if award.expires_in.positive?

    if award.name.eql? 'Blue First'
      if award.quality < 50
        award.quality += 1
      end
    end
  end
end