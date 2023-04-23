class BlueStar
  attr_reader :award

  def initialize(award)
    @award = award
  end

  def update
    award.expires_in -= 1
    return if award.quality.zero?

    award.quality -= 2
    award.quality -= 2 if award.expires_in <= 0
  end
end