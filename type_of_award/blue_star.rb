class BlueStar < AwardType
  def update
    super
    return if award.quality.zero?

    award.quality -= 2
    award.quality -= 2 if award.expires_in <= 0
  end
end