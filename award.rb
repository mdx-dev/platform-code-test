# Award = Struct.new(:name, :expires_in, :quality)

class Award
  QUALITY_CLAMP_VALUES = {
    min: 0,
    max: 50
  }

  attr_accessor :name, :expires_in
  attr_reader :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
    @quality_type = :decrement
  end

  def quality=(new_quality)
    @quality = new_quality
    @quality = @quality.clamp(QUALITY_CLAMP_VALUES[:min], QUALITY_CLAMP_VALUES[:max])
  end

  def update_quality
    if expires_in > 0
      self.quality -= 1
    else
      self.quality -= 2
    end

    update_expires_in
  end

  private

    def update_expires_in
      self.expires_in -= 1
    end

end
