Award = Struct.new(:name, :expires_in, :quality)

class Award
  BLUE_DISTINCTION_PLUS_QUALITY = 80
  def update_blue_first_quality
    # increase in quality as it gets older
    if self.quality_incrementable? && !self.is_expired?
      self.quality += 1
    elsif self.quality_incrementable?(1)
      self.quality += 2
    else
      self.quality = 50
    end
  end

  def update_blue_compare_quality
    #from 10 days to 6 days
    if self.expires_in < 11 &&
       self.expires_in > 5 &&
       self.quality_incrementable?(1)

      self.quality += 2 if quality_incrementable?(1)
      #from 5 days to 1 day
    elsif self.expires_in < 6 &&
          self.expires_in > 0

      self.quality += 3 if quality_incrementable?(2)
      #greater than 10 days and when it is expired
    elsif self.expires_in > 10
      self.quality += 1
    elsif self.is_expired?
      self.quality = 0
    end
  end

  #added in due to tests failing, not a part of the original description for the code challenge
  def update_blue_star_quality
    if self.expires_in < 6 &&
       self.expires_in > 0

      self.quality -= 2 if self.quality_decrementable?(1)
    elsif self.is_expired?
      self.quality -= 4 if self.quality_decrementable?(3)
    end
  end

  def update_quality
    if self.quality_decrementable?(1) && self.is_expired?
      self.quality -= 2
    elsif self.quality_decrementable?
      self.quality -= 1
    end
  end

  def is_blue_first?
    self.name == 'Blue First'
  end

  def is_blue_distinction_plus?
    self.name == 'Blue Distinction Plus'
  end

  def self.blue_distinction_plus_quality
    BLUE_DISTINCTION_PLUS_QUALITY
  end

  def is_expired?
    self.expires_in < 1
  end

  def quality_decrementable?(decrease_offset = 0)
    self.quality > (0 + decrease_offset)
  end

  def quality_incrementable?(increase_offset = 0)
    self.quality < (50 - increase_offset)
  end
end