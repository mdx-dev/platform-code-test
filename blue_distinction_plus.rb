class BlueDistinctionPlus < Award
  QUALITY_CLAMP_VALUES = 80

  def initialize(name, expires_in, quality)
    super(name, expires_in, QUALITY_CLAMP_VALUES)
  end

  def quality=(new_quality)
  end

  def update_quality
    update_expires_in
  end
end
