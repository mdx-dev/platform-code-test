class NormalItem

  attr_accessor :expires_in, :quality

  def initialize(expires_in, quality)
    @expires_in = expires_in
    @quality = quality
  end

  def update
    @expires_in -= 1
    self.decrease_quality(1)
    self.decrease_quality(1) if @expires_in <= 0
  end

  def increase_quality(amt)
    @quality = [50, @quality += amt].min
  end

  def decrease_quality(amt)
    @quality = [0, @quality -= amt].max
  end

end