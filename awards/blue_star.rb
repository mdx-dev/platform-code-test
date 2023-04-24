class BlueStar < AwardType
  private

  def update_attributes
    award.expires_in -= 1
    return if award.quality.zero?

    award.quality -= 2
    award.quality -= 2 if award.expires_in <= 0
  end
end
