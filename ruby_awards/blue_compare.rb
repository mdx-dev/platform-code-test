class BlueCompare
  include Award

  def initialize(expires_in=10, quality=25)
    @name = 'Blue Compare'
    @expires_in = expires_in
    @quality = quality
    raise 'Invalid Blue Compare Quality' if @quality > 50 || @quality < 0
    raise 'Invalid Blue Compare Expiry' if @expires_in < 0
  end

  def update_quality_and_expiry
    @quality +=2 if @expires_in > 5 && @expires_in <= 10 && @quality < 50
    @quality +=3 if @expires_in <=5 && @quality < 50
    @quality = 50 if @quality > 50
    @quality = 0 if @expires_in == 0
    @expires_in -= 1 if @expires_in > 0
  end
end
