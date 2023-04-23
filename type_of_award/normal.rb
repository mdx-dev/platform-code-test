class Normal < AwardType
  def update
    award.expires_in -= 1
    return if award.quality.zero?

    award.quality -= 1
    award.quality -= 1 if award.expires_in <= 0
  end
end