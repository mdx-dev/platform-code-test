module Award
  attr_reader :expires_in, :quality

  def initialize(expires_in, quality)
    validate_input(expires_in, quality)
    @expires_in = expires_in
    @quality = quality
  end

  def is_distinction_plus?
    self.class.name == "BlueDistinctionPlusAward"
  end

  def update_quality
    unless is_distinction_plus?
      update_expiry
      super
      normalize_quality
    end
  end

  def update_expiry
    @expires_in -= 1
  end

  def expired?
    @expires_in <= 0
  end

  def validate_input(expires_in, quality)
    raise "Invalid expiry" unless expires_in.is_a?(Integer)
    raise "Invalid quality" unless quality.is_a?(Integer) && (
      is_distinction_plus? ? quality == 80 : (0..50).include?(quality)
    )
  end

  def normalize_quality
    @quality = 50 if @quality > 50
    @quality = 0 if @quality < 0
  end
end

class BaseAward
  prepend Award

  def update_quality
    @quality -= (expired? ? 2: 1)
  end
end

class BlueFirstAward
  prepend Award

  def update_quality
    @quality += (expired? ? 2 : 1)
  end
end

class BlueDistinctionPlusAward
  prepend Award
end

class BlueCompareAward
  prepend Award

  def update_quality
    if @expires_in < 0
      @quality = 0
    elsif @expires_in <= 4
      @quality += 3
    elsif @expires_in <= 9
      @quality += 2
    else
      @quality += 1
    end
  end
end

class BlueStarAward
  prepend Award

  def update_quality
    @quality -= (expired? ? 4: 2)
  end
end
