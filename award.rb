# Award = Struct.new(:name, :expires_in, :quality)

class Award
  QUALITY_VALUES = {
    min: 0,
    max: 50
  }

  attr_accessor :name, :expires_in


  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def quality
    @quality
  end

  def quality=(new_quality)
    @quality = new_quality
    @quality = @quality.clamp(QUALITY_VALUES[:min], QUALITY_VALUES[:max])
  end
end
