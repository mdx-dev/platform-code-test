class BlueDistinctionPlusUpdater
  # Never decreases in quality, simply return the same award without change.
  # Per business logic, quality should be 80 and never alter.
  def self.update(award)
    raise StandardError.new "Award Type 'Blue Distinction Plus' must be of 80 quality" unless award.quality == 80

    award
  end
end