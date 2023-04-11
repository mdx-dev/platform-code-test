class GenericAwardUpdater  
  def self.update(award)
    award.quality -= 1 unless award.quality.zero?
    award.expires_in -= 1

    if award.expires_in < 0
      award.quality -= 1 unless award.quality.zero?
    end

    award
  end
end
