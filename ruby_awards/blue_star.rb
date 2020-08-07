class BlueStar
  include Award

  def initialize(expires_in=10, quality=20)
    @name = 'Blue Star'
    @expires_in = expires_in
    @quality = quality
    raise 'Invalid Blue Star Quality' if @quality > 50 || @quality < 0
    raise 'Invalid Blue Star Expiry' if @expires_in < 0
  end

  def update_quality_and_expiry
    # Decreasing quality every day to ensure it gets lesser as we move further away from the grant date
    @quality = @expires_in > 0 ? @quality - 1 : 0
    @quality = 0 if @quality < 0
    # Decreasing expiry twice as fast as normal (Blue Compare and Blue First) awards
    @expires_in = @expires_in > 1 ? @expires_in -= 2 : 0
  end
end
