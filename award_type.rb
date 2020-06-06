class AwardType

  attr_accessor :expires_in, :quality

  def initialize(expires_in, quality)
    @expires_in = expires_in
    @quality = quality
  end

  def increase_quality(amt)
    @quality = [50, @quality += amt].min
  end

  def decrease_quality(amt)
    @quality = [0, @quality -= amt].max
  end

  def decrement_expiration
    @expires_in -= 1
  end

  def blue_compare
    decrement_expiration
    if @expires_in < 0
      @quality = 0
    elsif @expires_in < 5
      increase_quality(3)
    elsif @expires_in < 10
      increase_quality(2)
    else
      increase_quality(1)
    end
  end

  def blue_distinction_plus

  end

  def blue_first
    decrement_expiration
    increase_quality(1)
    increase_quality(1) if @expires_in <= 0
  end

  def blue_star
    decrement_expiration
    if @expires_in <= 0
      decrease_quality(4)
    else
      decrease_quality(2)
    end
  end

  def normal_item
    decrement_expiration
    decrease_quality(1)
    decrease_quality(1) if @expires_in <= 0
  end

end
