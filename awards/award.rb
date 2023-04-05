class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update_quality
    @quality -= 1
    @quality -=1 if @expires_in <= 0

    @expires_in -= 1

    ensure_within_bounds
  end

  def ensure_within_bounds
    @quality = 0 if @quality < 0
    @quality = 50 if @quality > 50
  end
end