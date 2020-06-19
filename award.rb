class Award
  attr_accessor :name, :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def active?
    @expires_in >= 0
  end

  def decrement_quality
    return if @quality <= 0
    @name == 'Blue Star' ? @quality -= 2 : @quality -= 1
  end

  def increment_quality
    if @quality < 50
      @quality += 1
      increment_active_blue_compare
    end
  end

  def increment_active_blue_compare
    return if @name != 'Blue Compare' || !active?
    @quality += 1 if @expires_in < 11
    @quality += 1 if @expires_in < 6
  end

  def handle_expired
    return @quality = 0 if @name == 'Blue Compare'
    @name != 'Blue First' ? decrement_quality : increment_quality
  end
end
