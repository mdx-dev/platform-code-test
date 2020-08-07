class BlueDistinctionPlus
  include Award

  def initialize(expires_in=10, quality=80)
    @name = 'Blue Distinction Plus'
    @expires_in = expires_in
    @quality = quality
    raise 'Invalid Blue Distinction Plus Quality' if @quality != 80
    raise 'Invalid Blue Distinction Plus Expiry' if @expires_in < 0
  end

  def update_quality_and_expiry
    @expires_in -= 1 if @expires_in > 0
  end
end
