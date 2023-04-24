class BlueCompare < AwardType
  def update_attributes
    award.expires_in -= 1
    return if award.quality >= 50
    return award.quality = 0 if award.expires_in.negative?

    award.quality += 1
    award.quality += 1 if award.expires_in < 10
    award.quality += 1 if award.expires_in < 5
  end
end
