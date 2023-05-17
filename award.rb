QUALITY_LOWER_LIMIT = 0
QUALITY_UPPER_LIMIT = 50
BLUE_COMPARE_DEADLINE_1 = 5
BLUE_COMPARE_DEADLINE_1_QUALITY_THRESHOLD = 3
BLUE_COMPARE_DEADLINE_2 = 10
BLUE_COMPARE_DEADLINE_2_QUALITY_THRESHOLD = 2
BLUE_STAR_DECAY_RATE_EXPIRED = 4
BLUE_STAR_DECAY_RATE_DEFAULT = 2
BLUE_DINSTINCTION_PLUS_QUALITY = 80
RATE_DEFAULT = 1
RATE_DOUBLE = 2

class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    case self.name
    when 'Blue First'
      update_blue_first_award
    when 'Blue Compare'
      update_blue_compare_award
    when 'Blue Star'
      update_blue_star_award
    when 'Blue Distinction Plus'
      update_blue_distinction_plus
    else
      update_normal_award
    end
    
    unless self.name == 'Blue Distinction Plus'
      maintain_quality_limits
      decrease_expiration
    end
  end

  private

  def maintain_quality_limits
    self.quality = quality.clamp(QUALITY_LOWER_LIMIT, QUALITY_UPPER_LIMIT)
  end

  def expired?
    self.expires_in <= 0
  end

  def update_normal_award
    self.quality -= expired? ? RATE_DOUBLE : RATE_DEFAULT
  end
  
  def update_blue_first_award
    self.quality += expired? ? RATE_DOUBLE : RATE_DEFAULT
  end
  
  def update_blue_compare_award
    if expired?
      self.quality = 0
    elsif self.expires_in <= BLUE_COMPARE_DEADLINE_1
      self.quality += BLUE_COMPARE_DEADLINE_1_QUALITY_THRESHOLD
    elsif self.expires_in <= BLUE_COMPARE_DEADLINE_2
      self.quality += BLUE_COMPARE_DEADLINE_2_QUALITY_THRESHOLD
    else
      self.quality += RATE_DEFAULT
    end
  end
  
  def update_blue_star_award
    self.quality -= expired? ? BLUE_STAR_DECAY_RATE_EXPIRED : BLUE_STAR_DECAY_RATE_DEFAULT
  end

  def decrease_expiration
    self.expires_in -= RATE_DEFAULT
  end

  def update_blue_distinction_plus
    self.quality = BLUE_DINSTINCTION_PLUS_QUALITY
  end
end
