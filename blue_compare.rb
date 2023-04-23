class BlueCompare
  attr_reader :award

  def initialize(award)
    @award = award
  end

  def update
    award.expires_in -= 1
    return if award.quality >= 50
    return award.quality = 0 if award.expires_in.negative?

    award.quality += 1
    award.quality += 1 if award.expires_in < 10
    award.quality += 1 if award.expires_in < 5
  end
end