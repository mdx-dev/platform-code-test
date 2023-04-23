class AwardType
  attr_reader :award

  def initialize(award)
    @award = award
  end

  def update
    award.expires_in -= 1
  end
end