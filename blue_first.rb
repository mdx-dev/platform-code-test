class BlueFirst
  attr_reader :award

  def initialize(award)
    @award = award
  end

  def update
    award.expires_in -= 1

    award.quality += 1
    award.quality += 1 if award.expires_in <= 0
    return award.quality = 50 if award.quality >= 50
  end
end