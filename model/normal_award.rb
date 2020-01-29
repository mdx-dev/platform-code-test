class NormalAward
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def update!
    diff = expires_in > 0 ? 1 : 2
    @quality = [@quality - diff, 0].max
    @expires_in -= 1
  end
end
